﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Domain
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class NativeGuestEntities : DbContext
    {
        public NativeGuestEntities()
            : base("name=NativeGuestEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Booking> Bookings { get; set; }
        public virtual DbSet<Confirm> Confirms { get; set; }
        public virtual DbSet<Country> Countries { get; set; }
        public virtual DbSet<Job> Jobs { get; set; }
        public virtual DbSet<Nationality> Nationalities { get; set; }
        public virtual DbSet<API> APIs { get; set; }
        public virtual DbSet<Client> Clients { get; set; }
    }
}