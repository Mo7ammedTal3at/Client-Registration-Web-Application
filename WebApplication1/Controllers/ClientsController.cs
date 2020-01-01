using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Domain;
using WebApplication1.Models;
using System.IO;

namespace WebApplication1.Controllers
{
    public class ClientsController : Controller
    {
        private NativeGuestEntities db = new NativeGuestEntities();

        // GET: Clients
        public ActionResult Index()
        {
            var users = db.Clients.Include(u => u.Country).Include(u => u.Job).Include(u => u.Nationality);
            return View(users.ToList());
        }

        // GET: Clients/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client client = db.Clients.Find(id);
            if (client == null)
            {
                return HttpNotFound();
            }
            return View(client);
        }

        // GET: Clients/Create
        public ActionResult Create()
        {
            ViewBag.CountryID = new SelectList(db.Countries, "CountryID", "Country1");
            ViewBag.JobCode = new SelectList(db.Jobs, "JobCode", "JobTitle");
            ViewBag.NationalityID = new SelectList(db.Nationalities, "NationalityID", "Nationality1");
            return View();
        }

        // POST: Clients/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,FName,LName,Username,Password,Email,Phone,CountryID,DOB,NationalityID,Gender,JobCode,isAdmin,SchoolName,TimeZone,DeviceToken")] Client client, HttpPostedFileBase clientImage)
        {
           
             
            if (ModelState.IsValid)
            {
                if (clientImage != null && clientImage.ContentLength > 0)
                {
                    try
                    {
                        //Here, I create a custom name for uploaded image
                        string imageExtension = Path.GetExtension(clientImage.FileName);
                        string path = Path.Combine(Server.MapPath("~/Content/images"),client.Username + imageExtension);
                        clientImage.SaveAs(path);
                        // image_path is nvarchar type db column. We save the name of the file in that column. 
                    }
                    catch (Exception)
                    {
                        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                    }
                }
                db.Clients.Add(client);
                db.SaveChanges();
                if (!MakeConfirmEmail(client))
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest,"Error:Email not sent,try again later");
                }
                return View("success");
            }

            ViewBag.CountryID = new SelectList(db.Countries, "CountryID", "Country1", client.CountryID);
            ViewBag.JobCode = new SelectList(db.Jobs, "JobCode", "JobTitle", client.JobCode);
            ViewBag.NationalityID = new SelectList(db.Nationalities, "NationalityID", "Nationality1", client.NationalityID);
            return View(client);
        }
        
        // GET: Clients/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client client = db.Clients.Find(id);
            if (client == null)
            {
                return HttpNotFound();
            }
            ViewBag.CountryID = new SelectList(db.Countries, "CountryID", "Country1", client.CountryID);
            ViewBag.JobCode = new SelectList(db.Jobs, "JobCode", "JobTitle", client.JobCode);
            ViewBag.NationalityID = new SelectList(db.Nationalities, "NationalityID", "Nationality1", client.NationalityID);
            return View(client);
        }

        // POST: Clients/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "UserID,FName,LName,Username,Password,Email,Phone,CountryID,DOB,NationalityID,Gender,JobCode,isAdmin,isGuest,SchoolName,TimeZone,DeviceToken")] Client client)
        {
            if (ModelState.IsValid)
            {
                db.Entry(client).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CountryID = new SelectList(db.Countries, "CountryID", "Country1", client.CountryID);
            ViewBag.JobCode = new SelectList(db.Jobs, "JobCode", "JobTitle", client.JobCode);
            ViewBag.NationalityID = new SelectList(db.Nationalities, "NationalityID", "Nationality1", client.NationalityID);
            return View(client);
        }

        // GET: Clients/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client client = db.Clients.Find(id);
            if (client == null)
            {
                return HttpNotFound();
            }
            return View(client);
        }

        // POST: Clients/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Client client = db.Clients.Find(id);
            db.Clients.Remove(client);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
        public JsonResult IsEmailExist(string Email)
        {
            Client client = db.Clients.FirstOrDefault(u => u.Email == Email.Trim());
            if (client == null)
            {
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(false, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult IsUsernameExist(string Username)
        {
            Client client = db.Clients.FirstOrDefault(u => u.Username == Username.Trim());
            if (client == null)
            {
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(false, JsonRequestBehavior.AllowGet);
            }
        }
        
        [HttpGet]
        public ActionResult Confirm(int userId, string code)
        {
            Confirm f = db.Confirms.FirstOrDefault(c => c.UserId == userId && c.code == code);
            if (f == null)
            {
                return View("notConfirmed");
            }
            f.confirmed = true;
            db.Entry(f).State = EntityState.Modified;
            db.SaveChanges();
            return View("Confirm");
        }
        private bool SendConfirmEmail(string recieverEmail, string link)
        {
            GMailer.GmailUsername = "rreg707@gmail.com";
            GMailer.GmailPassword = "reg707pass";
            GMailer mailer = new GMailer();
            mailer.ToEmail = recieverEmail;
            mailer.Subject = "Email Confirmation";
            mailer.Body =
                "to confirm your email please click the following link\n"
                + "<a href=" + link + ">" + link + "</a>";
            mailer.IsHtml = true;
            return mailer.Send();
        }
        public bool MakeConfirmEmail(Client client)
        {
            Confirm cf = new Domain.Confirm();
            char[] chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".ToCharArray();
            Random r = new Random();
            string code = "";
            for (int i = 0; i < 15; i++)
            {
                code += chars[(r.Next() % chars.Length)];
            }
            cf.UserId = client.Id;
            cf.code = code;
            cf.confirmed = false;
            db.Confirms.Add(cf);
            db.SaveChanges();
            string link = Url.Action("Confirm", "Clients", new { userId = client.Id, code = code });
            string fulllink = Request.Url.GetLeftPart(UriPartial.Authority) + link;
            return SendConfirmEmail(client.Email, fulllink);
        }
    }
}
