//
//  PrayTimes.swift
//  NamazKeeper2
//
//  Created by Apple on 05.07.16.
//  Copyright © 2016 NU. All rights reserved.
//

import Foundation
import RealmSwift


class PrayTimes: Object{
    dynamic var date = ""
    dynamic var timedate = ""
    dynamic var day = ""
    dynamic var fajr = ""
    dynamic var sunrise = ""
    dynamic var dhuhr = ""
    dynamic var asr = ""
    dynamic var maghrib = ""
    dynamic var isha = ""
}

class UpdateByCity: Object{
    dynamic var cityId = 0
    let timingsForAYear = List<PrayTimes>()
}

class UpdateForAllCities: Object{
    dynamic var lastModified = ""
    let citiesTimings = List<UpdateByCity>()
}
class Settings: Object{
    dynamic var isFirstTime = true
    dynamic var city = 2
    dynamic var language = 0
    dynamic var notification = false
    dynamic var sound = 0
}

class Str: Object{
    dynamic var Message: String = ""
}


class NeededDays{
    var tomorrow: PrayTimes
    var today: PrayTimes
    var yesterday: PrayTimes
    
    init (tm: PrayTimes, td: PrayTimes, ys: PrayTimes){
        tomorrow = tm
        today = td
        yesterday = ys
    }
}


class Words{
    var words: [String] = ["","",""]
    init(kz: String,ru: String, en: String){
        words[0] = kz
        words[1] = ru
        words[2] = en
    }
}
class PrayTimesInWords{
    var prayTimesInWords = [Words(kz: "Таң", ru : "Фаджр", en: "Fajr"),
                            Words(kz: "Күн", ru : "Восход", en: "Sunrise"),
                            Words(kz: "Бесін", ru : "Зухр", en: "Dhuhr"),
                            Words(kz: "Екінті", ru : "Аср", en: "Asr"),
                            Words(kz: "Ақшам", ru : "Магриб", en: "Maghrib"),
                            Words(kz: "Құптан", ru : "Иша", en: "Isha")
    ]
    
}
class Languages{
    var lans = ["Қазақша", "Русский", "English"]
}
class Sounds{
    var sound = ["Standard", "Athan 1", "Athan 2", "Athan 3", "Athan 4"]
}
class Months {
    var months = [Words(kz: "Қантар", ru: "Январь", en: "January"),
                  Words(kz: "Ақпан", ru: "Февраль", en: "February")
    ,Words(kz: "Наурыз", ru: "Март", en: "March")
    ,Words(kz: "Сәуiр", ru: "Апрель", en: "April")
    ,Words(kz: "Мамыр", ru: "Май", en: "May")
    ,Words(kz: "Маусым", ru: "Июнь", en: "June")
    ,Words(kz: "Шiлде", ru: "Июль", en: "July")
    ,Words(kz: "Тамыз", ru: "Август", en: "August")
    ,Words(kz: "Қыркүйек", ru: "Сентябрь", en: "September")
    ,Words(kz: "Қазан", ru: "Октябрь", en: "October")
    ,Words(kz: "Қараша", ru: "Ноябрь", en: "November")
    ,Words(kz: "Желтоқсан", ru: "Декабрь", en: "December")]
}

class MonthsInIslamicDates{
    var months = [
        Words(kz: "Мұхаррам", ru: "Мухаррам", en: "Muharram"),
        Words(kz: "Сафар", ru: "Сафар", en: "Safar"),
        Words(kz: "Раби Әл-Әууәл", ru: "Раби Аль-Авваль", en: "Rabi-Al-Awwal"),
        Words(kz: "Раби Әс-Сәни", ru: "Раби Ас-Сани", en: "Rabi-Al-Thani"),
        Words(kz: "Джұмада Әл-Улә", ru: "Джумада Аль-Уля", en: "Jumada-Al-Awwal"),
        Words(kz: "Джұмада Әс-Сәни", ru: "Джумада Ас-Сани", en: "Jumada-Al-Thani"),
        Words(kz: "Режеб", ru: "Раджаб", en: "Rajab"),
        Words(kz: "Шағбан", ru: "Шаабан ", en: "Shaban"),
        Words(kz: "Рамадан", ru: "Рамадан", en: "Ramadan"),
        Words(kz: "Шәууәл", ru: "Шавваль", en: "Shawwal"),
        Words(kz: "Зүл-Қаада", ru: "Зуль-Каада", en: "Zul-Qaadah"),
        Words(kz: "Зүл-Хиджа", ru: "Зуль-Хиджа", en: "Zul-Hijjah")
    ]
}

class Weeks{
    var week = [
        Words(kz: "Жексенбі", ru: "Воскресение", en: "Sunday"),
        Words(kz: "Дүйсенбі", ru: "Понедельник", en: "Monday"),
        Words(kz: "Сейсенбі", ru: "Вторник", en: "Tuesday"),
        Words(kz: "Сәрсенбі", ru: "Среда", en: "Wednesday"),
        Words(kz: "Бейсенбі", ru: "Четверг", en: "Thursday"),
        Words(kz: "Жұма", ru: "Пятница", en: "Friday"),
        Words(kz: "Сенбі", ru: "Суббота", en: "Saturday")
        
    ]
}

class Cities{
    var cities = [
            Words(kz: "Астана", ru: "Астана", en: "Astana"),
            Words(kz: "Алматы", ru: "Алмата", en: "Almaty"),
            Words(kz: "Өскемен", ru: "Усть-Каменагорск", en: "Oskemen")
            /*Words(kz: "Семей", ru: "Семей", en: "Semey"),
            Words(kz: "Ақтау", ru: "Актау", en: "Aktau"),
            Words(kz: "Ақтөбе", ru: "Актобе", en: "Aktobe"),
            Words(kz: "Арқалық", ru: "Аркалык", en: "Arkalyk"),
            Words(kz: "Атырау", ru: "Атырау", en: "Atyrau"),
            Words(kz: "Жезқазған", ru: "Жезказган", en: "Zhezkazgan"),
            Words(kz: "Қарағанды", ru: "Караганда", en: "Karagandy"),
            
            Words(kz: "Көкшетау", ru: "Кокшетау", en: "Kokshetau"),
            Words(kz: "Қостанай", ru: "Костанай", en: "Kostanay"),
            Words(kz: "Қызылорда", ru: "Кызылорда", en: "Kyzylorda"),
            Words(kz: "Орал", ru: "Уральск", en: "Oral"),
            Words(kz: "Павлодар", ru: "Павлодар", en: "Pavlodar"),
            Words(kz: "Петропавл", ru: "Петропавл", en: "Petropavl"),
            Words(kz: "Тараз", ru: "Тараз", en: "Taraz"),
            Words(kz: "Шымкент", ru: "Шымкент", en: "Shymkent"),
            Words(kz: "Талдықорған", ru: "Талдыкорган", en: "Taldykorgan"),
            
            Words(kz: "Түркістан", ru: "Туркестан", en: "turkestan"),
            Words(kz: "Атбасар", ru: "Атбасар", en: "Atbasar"),
            Words(kz: "Степногорск", ru: "Степногорск", en: "Stepnogorsk"),
            Words(kz: "Қандыағаш", ru: "Кандагач", en: "Kandagash"),
            Words(kz: "Хромтау", ru: "Хромтау", en: "Hromtau"),
            Words(kz: "Шалқар", ru: "Шалкар", en: "Shalkar"),
            Words(kz: "Жаркент", ru: "Жаркент", en: "Zharkent"),
            Words(kz: "Қапшағай", ru: "Капшагай", en: "Kapchagai"),
            Words(kz: "Сарыөзек", ru: "Сарыозек", en: "Saryozek"),
            Words(kz: "Үшарал", ru: "Ушарал", en: "Usaral"),
            
            Words(kz: "Құлсары", ru: "Кульсары", en: "Kulsary"),
            Words(kz: "Мақат", ru: "Макат", en: "Makat"),
            Words(kz: "Миялы", ru: "Миялы", en: "Miyaly"),
            Words(kz: "Аягөз", ru: "Аягоз", en: "Aiyagoz"),
            Words(kz: "Риддер", ru: "Риддер", en: "Ridder"),
            Words(kz: "Жаңатас", ru: "Жанатас", en: "Zhanatas"),
            Words(kz: "Каратау", ru: "Каратау", en: "Karatau"),
            Words(kz: "Балқаш", ru: "Балкаш", en: "Balkash"),
            Words(kz: "Жайрем", ru: "Жайрем", en: "Zhairem"),
            Words(kz: "Сәтбаев", ru: "Сатбаев", en: "Satbayev"),
            
            Words(kz: "Рудный", ru: "Рудный", en: "Rudnyi"),
            Words(kz: "Арал", ru: "Арал", en: "Aral"),
            Words(kz: "Байконур", ru: "Байконур", en: "Baikonur"),
            Words(kz: "Қазалы", ru: "Казалинск", en: "Kazaly"),
            Words(kz: "Бейнеу", ru: "Бейнеу", en: "Beyneu"),
            Words(kz: "Форт-Шевченко", ru: "Форт-Шевченко", en: "Fort-Shefchenko"),
            Words(kz: "Жаңаөзен", ru: "Жанаозен", en: "Zhanaozen"),
            Words(kz: "Екібастұз", ru: "Екибастуз", en: "Ekibastuz"),
            Words(kz: "Жетісай", ru: "Жетису", en: "Zhetisu"),
            Words(kz: "Сарыағаш", ru: "Сарыагач", en: "Saryagash"),
            
            Words(kz: "Шардара", ru: "Шардара", en: "Shardara"),
            Words(kz: "Ақсай", ru: "Аксай", en: "Aksay"),
            Words(kz: "Чапаев", ru: "Чапаев", en: "Chapayev"),
            Words(kz: "Жаңақала", ru: "Жанакала", en: "Zhanakala"),
            Words(kz: "Жәнібек", ru: "Жанибек", en: "Zhanibek"),
            Words(kz: "Сайқын", ru: "Сайкын", en: "Saikyn")*/
        ]
}









