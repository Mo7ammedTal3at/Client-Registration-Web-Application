//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Confirm
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string code { get; set; }
        public bool confirmed { get; set; }
    
        public virtual Client Client { get; set; }
    }
}
