import FirebaseFirestore

final class UserSeeder {

    static func seedUsers() {
        let db = Firestore.firestore()

        let users: [[String: Any]] = [
            ["name": "Ahmed Ali", "email": "ahmed.ali@gmail.com", "role": "admin", "status": "active"],
            ["name": "Fatima Hassan", "email": "fatima.hassan@gmail.com", "role": "adviser", "status": "active"],
            ["name": "Mohammed Salman", "email": "mohammed.salman@gmail.com", "role": "student", "status": "pending"],
            ["name": "Aisha Yusuf", "email": "aisha.yusuf@gmail.com", "role": "student", "status": "active"],
            ["name": "Hassan Ibrahim", "email": "hassan.ibrahim@gmail.com", "role": "adviser", "status": "inactive"],
            ["name": "Noor Khalid", "email": "noor.khalid@gmail.com", "role": "student", "status": "active"],
            ["name": "Omar Saeed", "email": "omar.saeed@gmail.com", "role": "student", "status": "active"],
            ["name": "Zainab Abbas", "email": "zainab.abbas@gmail.com", "role": "student", "status": "pending"],
            ["name": "Ali Jawad", "email": "ali.jawad@gmail.com", "role": "adviser", "status": "active"],
            ["name": "Sara Mahmood", "email": "sara.mahmood@gmail.com", "role": "student", "status": "inactive"],

            ["name": "Yusuf Rahman", "email": "yusuf.rahman@gmail.com", "role": "student", "status": "active"],
            ["name": "Maryam Abdulrahman", "email": "maryam.abdulrahman@gmail.com", "role": "student", "status": "active"],
            ["name": "Abdulla Fardan", "email": "abdulla.fardan@gmail.com", "role": "adviser", "status": "active"],
            ["name": "Laila Nasser", "email": "laila.nasser@gmail.com", "role": "student", "status": "pending"],
            ["name": "Huda Salman", "email": "huda.salman@gmail.com", "role": "student", "status": "active"],
            ["name": "Khalid Ahmed", "email": "khalid.ahmed@gmail.com", "role": "student", "status": "inactive"],
            ["name": "Reem Al-Sayed", "email": "reem.alsayed@gmail.com", "role": "student", "status": "active"],
            ["name": "Mahdi Noor", "email": "mahdi.noor@gmail.com", "role": "student", "status": "active"],
            ["name": "Faisal Kareem", "email": "faisal.kareem@gmail.com", "role": "adviser", "status": "active"],
            ["name": "Dana Jasim", "email": "dana.jasim@gmail.com", "role": "student", "status": "pending"],

            ["name": "Sayed Abbas", "email": "sayed.abbas@gmail.com", "role": "student", "status": "active"],
            ["name": "Rana Qasim", "email": "rana.qasim@gmail.com", "role": "student", "status": "inactive"],
            ["name": "Hussain Ridha", "email": "hussain.ridha@gmail.com", "role": "student", "status": "active"],
            ["name": "Noura Ahmed", "email": "noura.ahmed@gmail.com", "role": "student", "status": "active"],
            ["name": "Bilal Farooq", "email": "bilal.farooq@gmail.com", "role": "adviser", "status": "active"],
            ["name": "Iman Saadi", "email": "iman.saadi@gmail.com", "role": "student", "status": "pending"],
            ["name": "Yara Salman", "email": "yara.salman@gmail.com", "role": "student", "status": "active"],
            ["name": "Tariq Mansoor", "email": "tariq.mansoor@gmail.com", "role": "student", "status": "inactive"],
            ["name": "Amal Jaffar", "email": "amal.jaffar@gmail.com", "role": "student", "status": "active"],
            ["name": "Mustafa Jawad", "email": "mustafa.jawad@gmail.com", "role": "student", "status": "active"],

            ["name": "Rami Khalifa", "email": "rami.khalifa@gmail.com", "role": "student", "status": "active"],
            ["name": "Nada Ismail", "email": "nada.ismail@gmail.com", "role": "student", "status": "pending"],
            ["name": "Salman Yusuf", "email": "salman.yusuf@gmail.com", "role": "student", "status": "active"],
            ["name": "Hiba Naji", "email": "hiba.naji@gmail.com", "role": "student", "status": "inactive"],
            ["name": "Karim Adel", "email": "karim.adel@gmail.com", "role": "student", "status": "active"],
            ["name": "Rasha Fadel", "email": "rasha.fadel@gmail.com", "role": "student", "status": "active"],
            ["name": "Majid Hasan", "email": "majid.hasan@gmail.com", "role": "student", "status": "pending"],
            ["name": "Samar Taha", "email": "samar.taha@gmail.com", "role": "student", "status": "active"],
            ["name": "Nabil Qureshi", "email": "nabil.qureshi@gmail.com", "role": "student", "status": "active"],
            ["name": "Hanan Rashed", "email": "hanan.rashed@gmail.com", "role": "student", "status": "inactive"],

            ["name": "Adnan Saleh", "email": "adnan.saleh@gmail.com", "role": "student", "status": "active"],
            ["name": "Zahra Mousa", "email": "zahra.mousa@gmail.com", "role": "student", "status": "active"],
            ["name": "Basel Hameed", "email": "basel.hameed@gmail.com", "role": "student", "status": "pending"],
            ["name": "Mariam Kadhim", "email": "mariam.kadhim@gmail.com", "role": "student", "status": "active"],
            ["name": "Saif Al-Haddad", "email": "saif.alhaddad@gmail.com", "role": "student", "status": "active"]
        ]

        for user in users {
            var data = user
            data["isFavorite"] = false
            data["createdAt"] = Timestamp()

            db.collection("users").addDocument(data: data)
        }
    }
}
