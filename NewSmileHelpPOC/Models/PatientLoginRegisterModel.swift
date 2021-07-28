//
//  PatientLoginRegisterModel.swift
//  CONNECT2DTELEDENTAL
//
//  Created by Happy on 16/04/20.
//  Copyright © 2020 CONNECT2D. All rights reserved.
//

import UIKit


// MARK: - Patient Login model
struct PatientLoginRegisterModel: Codable {
    let status: Int?
    let message: String?
    var data: PatientLoginRegisterDataClass?
    let error: String?
    let info: PatientLoginRegisterInfo?
}

// MARK: - Delete account model
struct DeleteAccountModel: Codable {
    let status: Int?
    let message: String?
    var data: DeleteAccountDataClass?
    let error: String?
    let info: PatientLoginRegisterInfo?
}

// MARK: - DataClass
struct PatientLoginRegisterDataClass: Codable {
    let token: String?
    var user: PatientLoginRegisterUser?
    let medicalHistory: [PatientLoginRegisterMedicalHistory]?

    enum CodingKeys: String, CodingKey {
        case token, user
        case medicalHistory = "medical_history"
    }
}


// MARK: - DeleteAccountDataClass
struct DeleteAccountDataClass: Codable {
    let token: String?
    enum CodingKeys: String, CodingKey {
        case token
    }
}

// MARK: - MedicalHistory
struct PatientLoginRegisterMedicalHistory: Codable {
    let id: Int?
    let condition: String?
}

// MARK: - User
struct PatientLoginRegisterUser: Codable {
    let id: Int?
    let email, emailVerifiedAt: String?
    let uniqueCode: String?
    let firstName, lastName, phoneNumber, dob: String?
    let gender: String?
    let userTypeID: Int?
    let profilePicture: String?
    let familyDentist : Int?
    let latitude, longitude: Double?
    let availability, status, createdAt, updatedAt: String?
    let medication: [PatientLoginRegisterMedication]?
    let medicalHistory: [PatientLoginRegisterMedicalHistory]?
    let allergies: [PatientLoginRegisterAllergy]?
    let notes: [PatientLoginRegisterNote]?
    let appointmentDetails: [PatientLoginRegisterAppointmentDetail]?
    let familyDentistDetails : [String]?
    let governmentID: [PatientLoginRegisterGovernmentID]?
    let address: [PatientLoginRegisterAddress]?
    let completionLevel : String?
    var paymentDetails: [PatientLoginRegisterPaymentDetail]?
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case emailVerifiedAt = "email_verified_at"
        case uniqueCode = "unique_code"
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case dob, gender
        case userTypeID = "user_type_id"
        case profilePicture = "profile_picture"
        case familyDentist = "family_dentist"
        case latitude = "latitude"
        case longitude = "longitude"
        case availability, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case medication
        case medicalHistory = "medical_history"
        case allergies, notes
        case appointmentDetails = "appointment_details"
        case familyDentistDetails = "family_dentist_details"
        case governmentID = "government_id"
        case address
        case completionLevel = "completion_level"
        case paymentDetails = "payment_details"
    }
}

// MARK: - Address
struct PatientLoginRegisterAddress: Codable {
    let id: Int?
    let clinicName: String?
    let address, address2: String?
    let aptUnit: String?
    let city, state, postalCode, country: String?
    let latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case clinicName = "clinic_name"
        case address, address2
        case aptUnit = "apt_unit"
        case city, state
        case postalCode = "postal_code"
        case country, latitude, longitude
    }
}

// MARK: - Allergy
struct PatientLoginRegisterAllergy: Codable {
    let id, allergyID: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case allergyID = "allergy_id"
        case name
    }
}


// MARK: - GovernmentID
struct PatientLoginRegisterGovernmentID: Codable {
    let id: Int?
    let governmentFront: String?
    let governmentBack: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case governmentFront = "government_front"
        case governmentBack = "government_back"
        case updatedAt = "updated_at"
    }
}

// MARK: - AppointmentDetail
struct PatientLoginRegisterAppointmentDetail: Codable {
    let id: Int?
    let lastAppointmentDt: String?
    let others: String?

    enum CodingKeys: String, CodingKey {
        case id
        case lastAppointmentDt = "last_appointment_dt"
        case others
    }
}

// MARK: - Medication
struct PatientLoginRegisterMedication: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Note
struct PatientLoginRegisterNote: Codable {
    let id: Int?
    let title, note: String?
}

// MARK: - PaymentDetail
struct PatientLoginRegisterPaymentDetail: Codable {
    let id: Int?
    var cardHolderName: String?
    var cardBrand, cardLastFour: String?
    var cardDefault: Int?
    var cardStripeID : String?

    enum CodingKeys: String, CodingKey {
        case id
        case cardHolderName = "card_holder_name"
        case cardBrand = "card_brand"
        case cardLastFour = "card_last_four"
        case cardDefault = "default"
        case cardStripeID = "stripe_card_id"
    }
}

// MARK: - PaymentDetail
struct PatientCheckoutPayment: Codable {
    let id: String?
    var card_holder_name, card_brand: String?
    var card_last_four: Int?
    var `default`: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case card_holder_name = "card_holder_name"
        case card_brand = "card_brand"
        case card_last_four = "card_last_four"
        case `default` = "default"
    }
}


// MARK: - Info
struct PatientLoginRegisterInfo: Codable {
    let apiVersion, status, format: String?
    let responseCode: Int?
    let generatedAt: String?

    enum CodingKeys: String, CodingKey {
        case apiVersion = "api_version"
        case status, format
        case responseCode = "response_code"
        case generatedAt = "generated_at"
    }
}





