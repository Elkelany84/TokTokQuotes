import 'package:get/get.dart';
// import 'package:toktok_quote/models/sqldb.dart';

class CounterController extends GetxController {
// SqlDb sqlDb = SqlDb();
  List myfavorites = [].obs;
//  Future readData() async {
//     //shortcut function
//     List<Map> response = await sqlDb.readShort('favorites');
//     // List<Map> response = await sqlDb.readData('SELECT * FROM notes');
//    myfavorites.addAll(response);
//     // isLoading = false;

//     return response;
//   }
}

List quotes = [
  "الرجولة لها ناسها وأنتم اللى قلتم إن احنا أساسها",
  "قلة الأصل مبدأ هتبدأ هبدأ",
  "ابن المعلم معلم",
  "تعدى حدودك الغى وجودك",
  "عاكسها بس ما تلمسهاش",
  "لما الديك يبيض هعديك",
  "شربت العذاب من الكأس لما فارقت أعز الناس",
  "العيب مش فى الحديدة العيب فى السواقين الجديدة",
  "عضة أسد ولا نظرة حسد",
  "امشى دغرى مهما كان الشمال مغرى",
  "لو شفت غراب أبيض هتلاقى صاحب جدع",
  "براحتها عشان صحتها",
  "لو صخر الجبال اتبدل احنا ما بنتبدلش",
  "حقد وغيرة من ناس كتيرة",
  "الرجولة فى خطر",
  "عاجباك ولا حارقاك",
  "اللى يخاف يتأكل حاف",
  "لا تلوم العايب و لا ترقع فى الدايب",
  "دلع الزبون",
  "طول ما فى شامبو للقشرة مفيش صاحب يصون العشرة",
  "عتاب الندل اجتنابه",
  "عادى يعنى لو الحب ضاع ممكن تأخدله برشامة صداع",
  "هجنك عشان أحسن منك",
  "طول ما أخويا غايب ماليش حبايب",
  "الصاحب السكة ما يساويش شوية فكة",
  "مش كل النبيتى تفاح",
  "المكتوب مفيش منه هروب",
  "اكرهنى بس ما تجبنيش مصلحة",
  "طول ما الحقد فى دمكم هفضل عمكم",
  "صحاب سكة ما الشتريهمش بفكة",
  "دوبنا وعدينا ومحدش خيره علينا",
  "من أول ما ابتدينا و العين علينا",
  "لو عاجباك بيع اللى معاك",
  "الملح داب و العيش أكله الكلاب",
  "لما السيجارة اتطفت الصحاب اختفت",
  "المهرة يابانى و فارسها إسكندرانى",
  "تركب هأدلعك تنزل هأدفعك",
  "شغل فاخر جايب من الآخر",
  "لو كان البلد ديه فيها خير مكانوش ربطوا الكوباية فى الكولدير",
  "كريم فى العطاء حليم فى القضاء",
  "اللى عايش على قده مفيش حد قده",
  "أخلاق مش سباق",
  "اللى تتمناه ليا يجعله ليك مش ليا",
  "تاب علينا ربنا من...",
  "أمير فى زمن حقير",
  "روجينا فرحتنا و رودينا ضحكتنا",
  "السواق لابس بيجاما و عامل حوادث ياما",
  "السواقة فن مش عن عن",
  "مش كاتب حاجة",
  "أيام فاتت وعشرة هانت وصحاب بانت",
  "اللى مش حريف يمشى على الرصيف",
  "نفسى أبطل أعيش لغيرى",
  "الصحاب فى كل حتة الرجولة خمسة ستة",
  "لا تضيع هيبة الصمت بالتافه من الكلام",
  "طنش وابتسم",
  "الستات زى القهوة دلقهم خير",
  "شباب كرموز دايما بيفوز وعلى أى حد يدوس",
  "الرجولة سلاحى وده سر نجاحى",
  "ما تبصش وتغير أصلى بحب التغيير",
  "الدنيا خسارة فى ناس غدارة",
  "when I forgive I forget",
  "حمو تاب بعد رحلة عذاب",
  "Be patien great things comes later",
  "كله مِتسجل بس الحساب متأجل",
  "ده مش كتر مال ده عند فى الأندال",
  "البداية كانت لك و النهاية بهون عليك",
  "تاخدوا كام وتبطلوا كلام",
  "نفسى أشوف واحد بوش واحد",
  "من غدر الصحاب عظمت للكلاب",
  "لو صاحبك خان اعتبره دخان",
  "سهل تحب صعب تتحب",
  "الصاحب مالوش أمان زى الفرامل و النسوان",
  "البركة فى اللى جاى",
  "بطلوا كلام يا ولاد الحرام",
  "لو فى حد مهيأله الرجولة بتشتاق له",
  "كل ما تحسدنى ربنا يزيدنى",
  "الجدع لما اتوجع الكل سابه وخلع",
  "بمزاجنا ولمزاجنا",
  "اصعب دمعتين دمعة مظلوم ودمعة محروم",
  "الشياكة صنعتى و الشقاوة لعبتى والحرام مش سكتى",
  "الصاحب الناقص بناقص",
  "عبد الراضى و الدلع ضاضى",
  "بدل ما تقعد تبص اتعلم ازاى ترص",
  "كفاءة الناظر يا شوية مناظر",
  "بس ما تقولش توكتوك",
  "النصيحة زى الحقنة أولها يوجع وآخرها يريح",
  "لما كلها بقت فرسان امال مين غلبان",
  "اللى طبعه راجل احسن من اللى شكله راجل",
  "ابن الفقير فى الشغل سهران و ابن الغنى فى البار سكران",
  "الدنيا ضاقت عليا حتى حبيبى اللى كان ليا",
  "جمعونا أغراب و فرقونا أحباب",
  "لو مستغرب لسه فيه أغرب",
  "قبل المطب بدلعها و بعد المطب بولعها",
  "لو كان للنوايا صوت يا فضيحة البشر",
  "كله بالحب الا الحب",
  "لو مفيش واسطة على جنب يا اسطى",
  "مش بالساهل تلاقى حد يستاهل",
  "لا أمان للامان",
  "على الهادى يا زبادى",
  "خلصانة معايا",
  "موبايل من غير نت زى الراجل من غير ست",
  "اللى ما يسيبش للرحمة باب يستاهل كل العذاب",
  "طول ما التلاجة محتاجة اشتغل اى حاجة",
  "الراية المرفوعة و الكلمة المسموعة",
  "ماتقولش صحاب تانى ده الاصلى باع الالمانى",
  "لو انت فاكر نفسك أحسن منى بكرة تيجى وتقولى علمنى",
  "اهون عليك تهون عليا",
  "جايبها نزاهة لنا مش عشان تصرف علينا",
  "لو صاحبك خروف بيعه من غير كسوف",
  "اتنين بس القلب واحد",
  "بيحسدونى عليكى وانتى سر عذابى",
  "مجهول الهوية وهحط على كل البشرية",
  "كلمة السر الصاحب مستمر",
  "فى ظهرك كلام زى السكاكين وفى وشك أولياء الله الصالحين",
  "ما تكلموش فى ضهرنا الكلام بيوصلنا",
  "انا ماليش فى العتاب انا عتابى غياب",
  "مش كل من شال السلاح بقى سفاح",
  "الرجالة بتتعرف و الفلوس بتتصرف",
  "يارب اعط كل إنسان ضعف ما يتمناه لى",
  "الرجولة قبل الحمولة",
  "امركم عجيب ايها المصريون",
  "لو الجمل نخ فالعيب فى الحمولة مش فى الرجولة",
  "الرجولة مش بسهولة",
  "اما تعاشرنى هتعرف ليه الناس بتحبنى",
  "رجعت من تانى سلطان زمانى",
  "عيب الإنسان مفيهوش الا لسان",
  "اللى بيرزقنا واحد ومابينساش ولا واحد",
  "اللى عنده حمو مايشيلش همه",
  "من انهاردة مفيش تقدير ومعاملتى هتتغير لناس كتير",
  "على وضعنا لحد ما نقابل ربنا",
  "ادفع من غير كلام عشان ده مال أيتام",
  "اللى تعب وشقى غير اللى اللى اتولد ولقى",
  "لو فكرت تحلها هحطك تحتها",
  "بلاش تعمل دور الإخوة عشان انا عارفك من جوه",
  "تخبطها تحكها أحطك تحتها",
  "صاحبها مجنون وراكبها عفريت",
  "أخويا فى مقام أبويا",
  "من انهاردة هعتبركم ميتين ولو شفتكم هقول يخلق من الشبه أربعين",
  "صاحبى راجل بجد واتحدى به أى حد",
  "معدش يفيد",
  "لو صاحبك راجل بجد اضرب نار على أى حد",
  "صاحبى دراعى وعمى قرشى و اللى يقف على البر ما يغرقشى",
  "القلب مات واندفن و الجسم مستنى الكفن",
  "فى الوقت المناسب الكل هيتحاسب",
  "لو خايف من بكرة نام واصحى بعد بكرة",
  "احنا الأساس و الأصل و الباقى تلامذة جوه الفصل",
  "الجرى لعبتى",
  "خليك خفيف",
  "عليت ناس كانت واطية فى الأساس",
  "جرحك نسانى ملامحك",
  "الكلمة لو مش قدها نام واستغطى جنبها",
  "الجدع أنا عارفه و الباقى مش شايفه",
  "فى وشك أولياء الله الصالحين و فى ظهرك كلام زى السكاكين",
  "الله المستعان على زمن مابقاش فيه جدعان",
  "الحلوة من بوالينو و صاحبها انتم عارفينه",
  "عاملين معلمين بالاونطة",
  "مسير اللى داق يشتاق",
  "اللى قعد معايا واللى راح فدايا",
  "حب الخير للغير",
  "الشغل عند الناس يجرح الإحساس",
  "الجدع معروف و الندل مكشوف وتسلم الظروف",
  "اتعلمت فى بيت أبويا إن الصاحب الجدع فى مقام أبويا",
  "الرجولة عصب",
  "عايز تعرف تمامنا أسأل اللى وقف قدامنا",
  "ناس طلبت الصيت والغنىّ وأنا طلبت الستر من ربنا",
  "لو شايل منى بلاش تعاملنى",
  "عيش وماتحكيش",
  "لو زاد همك روح بوس إيد أمك",
  "النفوس مش صافية والاسم حبايب",
  "النية زى لون العربية",
  "سهلة بس عايزة قلب",
  "اللى رجله تجيبوا هيأخد نصيبوا",
  "شبعنا غم وكل يوم حرقم دم",
  "يتوب علينا ربنا من الناس المعفنة",
  "سمعت عن الحب عجبنى جربته جرحنى",
  "هتقل معايا مش هتفرق معايا",
  "الزمن اللى احنا فيه صعب الجدع تلاقيه",
  "بيحبونا لما يحتاجونا",
  "المخرج عايز كده",
  "احنا نتكلم و الناس تتعلم",
  "أخرس فى زمن رغاى",
  "دايخ فى زمن بايخ",
  "الغيرة حيرة",
  "كلمة تدمر وكلمة تعمر",
  "الدنيا فانية وربنا ادانا فرصة تانية",
  "الناس معاك على قد اللى معاك",
  "بنضحك غلب",
  "اللى الشوق مش هيجيبه المصلحة تجيبه",
  "سيبونا فى حالنا ده أنتم جبتم أجلنا",
  "غياب الديب عمل للغنم قيمة",
  "عجوز عجوز بس رياضى",
  "مفيش دماغ لوجع الدماغ",
  "لو مش عاجباك شخصيتى يبقى هتتعامل مع جزمتى ",
  "الزعامة غرامة",
  "لو حبيبك مش نصيبك اعتبره ليلة من لياليك",
  "النية سليمة يا ولاد اللئيمة",
  "لو خايف اعمل مش شايف",
  "اللهم اكفينا شر الغم و الهم وحرقة الدم",
  "اللى يعاكس المدام يبقى حكم على نفسه بالإعدام",
  "اللى أوله كلام آخره كلام واللى أوله سكوت آخره جبروت",
  "الصاحب اللى بجد ما يجبش سيرة حد",
  "اللى تقدر عليه اعمله واللى ما تقدرش عليه سيبه هو يكمله",
  "ديه مش تناكة ، أنا بس خدت على الشياكة",
  "أنا أسد بس بخاف من الحسد",
  "عضة تعبان ولا غدر إنسان",
  "اللى يدوس على طرفى يستحمل قرفى",
  "الأيامة اللى بجد ما تشغلش بالك بحد",
  "يا نقضيها انبساط يا نمشيها استعباط",
  "شافونى جدع صاحبونى لقونى راجل سابونى",
  "تسلم الظروف اللى حطت النقط على الحروف",
  "لما الكبير ما يحترمش نفسه الصغير يقل منه",
  "خلصنا الكليات وسوقنا التونيات",
  "انتحار على خط النار",
  "اطلع جدع مع مين وكلهم مش سالكين",
  "اختار اللى يكمل معاك مش اللى يكمل عليك",
  "أنا من جيهة ماتعرفش تجيها",
  "كل ما أروق يطلعلى خازوق",
  "قول يا باسط تلاقيها هاصت",
  "عاشر اليهود ولا تعاشر الحقود",
  "اتقل تتكيف تستعجل تتليف",
  "قرب عشان تجرب",
  "خد بالك من أفعالك عشان هأخد لفة و ارجعهالك",
  "اللى ما جاك ما خبرك",
  "عايز أوصل رسالة للى عاملين رجالة",
  "الله يحنن عليك بدل ما تهب عليك",
  "مش هشغل بالى بيكو عشان أنا احسن ما فيكو",
  "فى حالى أحلالى",
  "عيش الحياة بسعادة لأن الحياة مفيهاش إعادة",
  "محطة وكله نازل",
  "كشكشها وبلاش تعيشها",
  "لو أنت غبى هستحملك ، لو انت بجح هكعبلك",
  "مهما كان مستواك كما ترانى سوف اراك",
  "من غير كلام مفيش خصام",
  "اسلكوا لتهلكوا",
  "جدار الصداقة اتهد ومحدش بيقف لحد",
  "الحقد ماليهم بس الهزار مداريهم",
  "اللى ربنا معاه يمشى على المياه",
  "عشت جدع شبعت وجع",
  "لولا الستات كان زمان الشيطان عاطل",
  "ياللى لسه بتتكلموا عن نفسكم لسه ما سمعتش عنكم",
  "اللى يجى على ثلاث إخوات يبقى قلبه مات",
  "الاحترام للمحترم مش للكبير",
  "لو الرجولة مش فينا يبقى الموت أولى بينا",
  "ما تبصش وتبحلق لتقع تتزحلق",
  "كلام الناس هواية و ستر ربنا كفاية",
  "ديه قصة كفاح مش جاية على المفتاح",
  "لولا الضمير كنا عملنا كثير",
  "الخطوة بعد كده بحساب يا شوية كلاب",
  "العلواية دولة و ناسها عتاولة",
  "زرعناها أصول حرقولنا المحصول",
  "ما يعرفوش إنهم ما يشرفوش",
  "إحنا بالف خير و أنتم بالف جنيه",
  "أنا مش بغير أنا بحب التغيير",
  "المعاملة بالمادة مش بالمودة",
  "قول لنفسك معلش",
  "شكر خاص للرخاص",
  "عملت بلوك لاصحابى",
  "لو حابب قلبتى تعالى على سكتى",
  "هنفضل أبطالها لحد ما نبطلها",
  "السمعة ميزان حساس",
  "قسمت الرغيف على إثنين لما لقيتهم بوشين",
  "بنفسى مش بيكوا ولنفسى مش ليكو",
  "الصيت على الأد بس مش بحس بحد",
  "لو المعلمين اهتمت مكانتش الشغلانة لمت",
  "يا بخت اللى إحنا من بخته",
  "حيلهم شد بس إحنا أشد",
  "يا تكون أد كلامك يا تخلى كلامك على أدك",
  "لقيتك أرخص من العتاب قلت أخسرك",
  "كلب يوفى ويصون أحسن من صاحب يغدر و يخون",
  "مفيش مغامر بيأخذ أوامر",
  "طول ما فيه بقاء لابد من لقاء",
  "لو صاحبك مش تمام يبقى شورة المدام",
  "مش على كيفكم بس مكيفكم",
  "لو كنت لقيت كنت جريت",
  "إنساهم هتلاقيم على حجرك قاعدين",
  "فراقنا عليك واعر",
  "اللى أنت بتشيلهم تحت البلاطة أنا بجيب بهم شيكولاته",
  "صعب الوصول لإبن الأصول",
  "طير يا حمام و خذ لفتك مسيرك ترجع يوم لغيتك",
  "الندل وقت المصلحة يجيلك ووقت الشدة مش فاضيلك",
  "أعيش لمين من غير حنين",
  "اللى متعود على النقص يفتكر الجدعنة كمين",
  "إثنان مالهمش أمان ، الصاحب و الزمان",
  "احترم الطريق يحترمك",
  "احركوا و إفركوا أنا برده عمكم",
  "أحلى سلاح الأدب",
  "إحنا أصل الدلع",
  "إحنا الأساس و علمنا كل الناس",
  "إحنا الأصل و الباقى فى الفصل",
  "إحنا الحكومة",
  "إحنا العالم الرايقة",
  "إحنا زى ما إحنا عمر الزمان ما جرحنا",
  "إحنا صغيرين بس معلمين",
  "اختار الصديق قبل الطريق",
  "اخترت صاحب جديد عشان القديم باعنى",
  "ادلعى يا كايداهم المحكمة موجودة",
  "إستوب إحنا التوب",
  "اسمع سمعت الرعد ، إحنا الصحاب اللى بنحب بعض",
  "اصبر يا قلبى",
  "أصعب خيانة لما تيجى من الصديق",
  "أصل الأصحاب أنواع",
  "أصلنا وفصلنا والأبيض قلبنا",
  "أعز ما ليا غدر بيا",
  "أكتب وسطر الألم",
  "الإحساس نعمة و اللى يكره يعمى",
  "الإستقامة أيامة",
  "الأسفلت ملعب و الكل بيلعب",
  "البحر طرح ودع مفيش صاحب جدع",
  "البحر واحد بس السمك أنواع",
  "التوكتوك المهم للمشوار المهم",
  "الحب مش كلمة",
  "الحبُوب ملك القلوب",
  "الحلوة من الهند وصاحبها اسمه جبار سنج",
  "الحوت فى الغريق وكتكوت على الطريق",
  "الخواجة قالك ماتصعش عشان حقك مايضعش",
  "الدلع مش ليكو",
  "الدلع موضة",
  "الدنيا إتقل خيرها والناس باعت ضميرها",
  "الدنيا بالمال والآخرة بالأعمال",
  "الدنيا بالمظاهر بس الأصل ظاهر",
  "الدنيا بتتغير و بتعلى الصغير",
  "الدنيا رحلة عذاب",
  "الدنيا غدارة من زمان و الطيبين مالهمش مكان",
  "الدنيا لحظات والدموع درجات",
  "الدنيا لقاء وفراق",
  "الدنيا مدرسة و الشاطر يتعلم",
  "الرجولة مواقف والندالة دروس",
  "الرزق فى السماء والحب فى القلب والكذب فى اللسان",
  "الزمن دوار",
  "الزمن مش لعبة",
  "السمك مهما كبر الحوت هو الأصل",
  "الشدة تسلم عشان بتبين الراجل",
  "الصاحب اللى يضر سيبك منه",
  "الصحاب غيارة",
  "الصحاب فى إجازة",
  "الصحوبية أمانة مش غدر وخيانة",
  "الصمت لغتنا والدم لعبتنا",
  "الطيب طيب لنفسه",
  "العايق مرتاح",
  "العمر رحلة سفر والحياة حدوتة",
  "العيب مش فى العيش ، العيب فى اللى كلوه",
  "العيون كثير بس ربنا كبير",
  "الغايب راجع",
  "الغريب لو صح أحسن من ألف أخ",
  "الفراق قدرى ونصيبى الحب",
  "القلب بيتألم ولا يتكلم",
  "الكرم أصلنا والنزاهة طبعنا",
  "الكلمة مننا والحلم من عقلنا",
  "الكون كله مصالح وكلام الناس بقى جارح",
  "الكويس بيتكيس",
  "اللى أبوه صعيدى مايخافش",
  "اللى عايز الحلو يصبر على مراره",
  "اللى فينا مكفينا",
  "المخلصين قلوا والغدارين هلوا",
  "الندل ندل حتى لو حكم بالعدل",
  "إن عشت هذلكم وإن مت الله يسهلكم",
  "أنت بتضحك على أمك وإحنا بنضحك عليك",
  "أنا رحت الجيش وسبت الناس تأكل عيش",
  "أنا مظبطها اوعى تخبطها",
  "آه من اللى منى",
  "اوعى تجرى ورايا ، أختك مش معايا",
  "بحلم لو يوم الناس تحب بقلوبها الناس",
  "بص يا صاحبى وماتغيرش ولو غرت ماتحدسش",
  "بُعدك عنى انتحار",
  "بعهم يشتروك",
  "تحياتى لمن غيرت حياتى",
  "ترى أيهما أشد إيلاما ( لحظة الفراق نفسها أم لحظة الحنين بعد الفراق )",
  "تقفيل معلم ومحدش يقدر يتكلم",
  "تمنيت الموت فتذكرت دموع أمى",
  "جروحى كثير والسبب طيبتى",
  "حاسب يا عم الرجولة فى الدم",
  "حاولوا متقلدوناش",
  "حب اية يا جاهل مفيش بنت تستاهل",
  "حب اية يا غلبان مفيش بنت لها أمان",
  "حب عشان تنحب",
  "حب وخداع والكل بياع",
  "حبك قدر ومكتوب عليا",
  "حبيبى أنا بضعف ادامك كل ما بسمع كلامك",
  "حبيبى تحرم عليا تفرح عينيا بعدك",
  "حبيبى علمنى معنى الصبر",
  "حرمت أحب تانى",
  "خايف أسميك بحر ، الناس تغرق فيه",
  "خلعت دبلتى وبعت دنيتى",
  "خليك جرىء وعوم فى الغريق",
  "خليك ديب بلاش تخيب",
  "خليك مغرور لحد ما يجى عليك الدور",
  "دموع فى عيون جافة",
  "دنيا غرورة بألف صورة",
  "ده مالنا ومحدش بيسألنا",
  "ده نصيبك مش هواك",
  "راح تفضل لإمتى كده يا غلبان",
  "راحت حبيبتى منى",
  "سهل أحبك صعب أنساك",
  "شارب الحب طول عمره خسران",
  "شخلل عشان تعدى",
  "صاحب صاحب يخدعك أحسن من بنت تجرحك",
  "صاحب صاحب ينفعك أحسن من بنت تضيعك",
  "صاحب صاحبك على عيبه ، ما تصاحبوش على اللى فى جيبه",
  "صاحب كلب يحرسك ، وما تصاحبش صاحب يحبسك",
  "صاحبك اللى يحبك",
  "صاحبك مصلحتك",
  "صحابى غدارين مش عارف أصاحب مين",
  "صعب أديك الأمان",
  "صعب تبقى نصيبى",
  "حبى خسارة فى ناس غدارة",
  "صعبان عليا عشان مفيش حد ليا",
  "طايش بس عايش",
  "طلبت منك يارب حبيب بعتلى ملاك",
  "طول ما إيدى فى بقهم هفضل عمهم",
  "عاشق أنا وقلبى عنيد",
  "عالم سمسم والكل بيرسم",
  "عايز تبقى الريس عامل الناس كويس",
  "عايز تعرف أصلك افتكر ماضيك",
  "عايز تعيش وتشوف وشك يكون مكشوف",
  "عايز صاحبك يدوم صبحه كل يوم",
  "عايشين من غير قلوب",
  "عتاب الندل اجتنابه حضوره يشبه غيابه",
  "عشان عصفور اصطادونى وعشان ديب احترمونى",
  "عشت طيب انجرحت عشت خاين اندبحت",
  "عشت عصفور دبحونى",
  "عشقت السفر من ظلم البشر",
  "عندها ثلاثين فستان وبتشكى من الحرمان",
  "فاكرك وناسيك ودايما بفكر فيك",
  "فى خيط ضعيف رابط بيننا وهو ده النصيب",
  "قدر تتقدر",
  "قلب ميت مش كبرياء",
  "كان فى الأصل نظرة عين",
  "كان من المستحيل أنساك دلوقتى حب ومات",
  "كلب يحرسك ولا ندل يحبسك",
  "كن واقعيا واطلب المستحيل",
  "لا داعى لوداعى",
  "لا دنيا ولا صاحب ولا حد يتصاحب",
  "لا كارك ولا فنك إلعب بعيد أحسن لك",
  "للذكرى و التاريخ على كوكب المريخ إحنا الصواريخ",
  "لما الحبايب تخون يبقى مين هيصون",
  "لما ربنا أمر رجعت زى القمر",
  "لن أطلب الرحمة من أحد ولكن سيأتى يوما لن أرحم فيه أحد",
  "الهادى ربنا معاه والأصفر منه لله",
  "لو الشقاوة رتب كان زمانى بقيت لواء",
  "لو حاولت تفهم مش هتفهم",
  "لو سالت العذاب يحب يعذب مين؟ هيشاور عليا أنا",
  "لو كنت طير كنت هاجرت",
  "لو نام السبع شوية الكلاب يأكلوه",
  "ليه الأيام الحلوة عمرها قصير",
  "ليه تحسدونى ، أصحابى تعبوا على ما اشترونى",
  "ما بقاش فيها مبدأ",
  "ما تبكيش على اللى راح ماله ابكى على اللى وقف حاله",
  "ما تزعليش يا غندورة بكرة تبقى أمورة",
  "ما تسلك يا مان وسيبنى أعيش فى أمان",
  "ما تطلبش من العبد إنه يدعيلك ، اطلب من الرب إنه يديلك",
  "ما يقلقش منك إلا اللى أقل منك",
  "ماشى دايخ فى زمن بايخ",
  "مش مهم تحب المهم تنحب",
  "مش هجرى وأدوس زى كلاب الفلوس",
  "مش هيصعب علينا عشان مصعبناش على حد",
  "مشى إيديك شوية",
  "تحياتى لمن دمرت حياتى",
  "مفيش صاحب يتصاحب ولا بنت تتحب",
  "ملقتش أصحاب فى مصر بعت أجيب من الصين",
  "ممكن بس إزاى ؟",
  "من غدر الصحاب صاحبت الكلاب",
  "من غدركم كرهتكم",
  "من غدرهم كرهتهم وهما اعز الأصحاب",
  "مين باع مين ؟",
  "ناس عيانة من غير عيا",
  "نحن نكون حتى لا يتمرد الآخرون",
  "نزلت حاجبها وبرده محدش عاجبها",
  "نصيحة منى ليك ماتزعلش اللى شاريك",
  "نفسى أصاحب راجل",
  "هتترسموا عليا هدوسكم برجليا",
  "هوايته صيد الغزلان وتربية الفرسان",
  "وحدانى و الدنيا مش مساعدانى",
  "ولد ابن ولد على الشقاوة اتولد",
  "يا صاحبى إحنا غلابة بس ساعة الشر بنبقى غابة",
  "يا صاحبى اللى مش فى إيدك بيكيدك",
  "يا صاحبى لو تنسانى ماتنساش الماضى",
  "مازال البحث جاريا عن الرجولة",
  "الحب تجارة وأنت فى الآخر خسارة",
  "عبقرى فى زمن طرى",
  "هنلعب رياضة و الكل هيتراضى",
  "شىء غريب لا صاحب ولا حبيب",
  "دمى ولا دموع أمى",
  "الحب مات بسبب البنات",
  "لو الحياة خوف يبقى الموت أفضل",
  "الكار ده مش كارنا يارب صبرنا",
  "لو يوم تميل أنا  كتافي تشيل",
  "عملنا ومطمرش مع ناس مبتقدرش",
  "البني ادم زي الإنسان إذا توفي مات",
  "بلاش اندهاش لسه التقيل مجاش",
  "الدنيا زي الميزان مابترفعش غير الناقص",
  "اللي متعرفش تعدله بدله",
  "إحنا أسوووود لحد مانموووووت",
  "عنينا مش خضرة بس الهيبة حاضرة",
  "ما لم يُعتبر صار عِبرة",
  "تزعلك الدنيا ويراضيك ربنا",
  "المركب اللى فيها ربنا ماتغرقش",
  "لو متعلمتش من اللى فات الجاي هيعلم عليك",
  "نفسي أشوف لكم عشان اشهد لكم",
  "الغل ماليكو بس الضحك مداريكو",
  "المليونير اللي يصرف مش يحوش",
  "غياب الديب يعمل للغنم هيبة",
  "التفكير في اللي ضاع ميجبش غير صداع",
  "اسأل عليا عشان بيصعب عليا",
  "ليه كدا يا دنيا بتحطي ع جرحي كولونيا",
  "ذكراكم رخيصة وأنا واقتي غالي",
  "كل شيء بالأمل إلا الرزق بالعمل.",
  "من يومنا كعوبنا شايلانا ومِستحمله شقانا",
  "احنا مش من المعادي ياكوبيات زبادي",
  "فى ناس محل ثقة وناس محل جزم",
  "اللي يزعل من الأصول مترباش عليها",
  "اللى متعود ع الرخيص ميعرفش يصون الغالي",
  "اللى هيمد إيديه هعلم عليه",
  "انا اللى يأكل معايا عيش أحارب عشانه جيش",
  "الحب زي الحرب عايز رجاله",
  "كلب صاحب أفضل من صاحب كلب",
  "ربنا يكفيكم شر النفوس لما بيدخل بينهم الفلوس",
  "الفلوس أهم من النفوس عند الرخيص",
  "ياسطا عم عشم مات لا خلف بت ولا واد",
  "الي تعرف تمامه سيبك من كتر كلامه",
  "لكل واحد شايل مني شيل اكتر عشان يطلعلك عضلات",
  "سابت كل الـ games ولعبت بمشاعري",
  "البسو أشيك طقم عندكم عشان هخرجكم من حياتي",
  // "من باعك بيعه.. واللي مابعكش بيعه برضو الإحتياط واجب",
  "جبت امر إزالة للناس الزبالة",
  "جاري الأن مسح الواطيين من حياتي",
  "اسمي سلطة زي كارنية الشرطة",
  "لف ذكرياتك في سيجارة وولعها",
  "أنا خايف ياصاحبي استعيذ من الشيطان تتحرق",
  "يا صحبة مش وراها غير الخسارة",
  "خالي بالك من اتنين جعان معاه قرشين وحمار اتعلم كلمتين",
  "صحاب هلاهيل كبيرهم تهليل",
  "لو متعلمتش من اللى فات اللى جاي هيعلم عليك",
  "ابعدوا عننا عشان عايزين نرضي ربنا",
  "حتى هدفي في الحياة طلع تسلل",
  "جدعنتي انا خلاص لغيتها عشان في ناس استغلتها والي فاكر قلبي طيب كل سنة وهو طيب",
  "تعبنا وشقينا ومحدش خيره علينا",
  "فرافير في لبسنا رجالة في طبعنا",
  "احنا بنفسنا وانتو بينا",
  "صحاب عصافير وقت الجد كلها بتطير",
  "مية سلام علي سلامكو ياللي المصلحة اصلها تمامكو",
  "اسلكو لنفسيكو عشان اجي اقعد وسطيكو",
  "لو التناكة واخداك احنا فوق مستواك",
  "شجرة العشم طرحت معلش",
  "بنات ايه ياعم اكل العيش اهم",
  "الحياة حلوه بس انتو اللي متجوزين",
  "اللي واخد مني موقف ربنا يوسع عليه وياخد جراش",
  "خد بالك من افعالك عشان حتلف لفه ورجعالك",
  "مش فاضي للكلام الفاضي",
  "في ناس كلامها تمام وفي ناس تمامها كلام",
  "لو الرجولة غالية عليك متلمش العيال حوليك",
  "تعمل حسابي أقدرك، تهزر معايا أعورك",
  "ان نام السبع ،شويه كــلاب يكلوه",
  "لما كنت عصفور كلونى، ولما بقيت اسد صاحبونى",
  "تركب اسليك , تنزل اولع فيك",
  "خدي بالك من الواد، أنا نازل يا سعاد",
  "طب وكمان شمعة مضلمة عشان اللى ما بيحبوناش",
  "سولار في التنك ولا مليون في البنك",
  "الي يخاف من العفريت يعمل عبيط",
  "شوفو الجديد يابلد التقليد",
  "هسيبك كده وريا انت مش مستوايا",
  "مش كل الناس ولاد ناس ولا كل الجزم نفس المقاس",
  "متفرحش لما بنت تقولك بحبك موت افرح لما صاحبك يقولك معاك علي خط الموت",
  "اللي يبيع يغتني سنة و اللي يشتري يفتقر سنة",
  "البحر مالح والناس مصالح",
  "اللي يسمع كلام الناس ما ينفعش و اللي ياكل حرام ما يشبعش",
  "الي يشتري اللي ملهوش لازمه يجي يوم و يبيع اللي ليه لازمة",
  "احنا اصحاب بجد واخرك معانا حاره سد ولو هاتمشيها عافيه هنتعارك ومش هانمشيها ود",
  "تعمل حسابي أقدرك تهزر معايا أعورك",
  "اللى عايزه يتحير شغل له النور الصغير",
  "الباشا من هيبته بيتشتم في غيبته",
  "جري الرجالة زي بحر النيل و جري الولاية زي نقط الزير",
  "الصبر طيب والرد قريب",
  "المشي البطال ياما بهدل أبطال",
  "مطرح ما بخطي بغطي",
  "أنا اللي يأكل معايا عيش احارب عشانه جيش",
  "مش كل حاجة أمل لازم تسعى للعمل",
  "سابت جوجل بلاي وجت تلعب بمشاعري",
  "المليونير يصرف والمعفن يحوش",
  "عايز تشوف شر النفوس؟ اظهر الفلوس",
  "اوعى تقول إنك كبير عشان الكبير مبيتكلمش",
  "طول ما الكلام ببلاش هتسمع صوت اللي ميسواش",
  "ممكن تحس إني غلبان بس لو جيت عليا كل المستخبي يبان",
  "اتصرف علينا أصول مش فلوس",
  "يعيش البجح على قفا المكسوف",
  "مين فى صفى عشان بصفى",
  "الزمن اللى جاى لا فيه راحة ولا براحة",
  "عينيهم ماشافتش بس لسانهم أخطر عين",
  "خذ نايبك صبر ",
  "عز اللى يعزك والباقى ولا يهزك",
  "صاحبى رجل جدع بس الندالة واخداه",
  "المخرج احتار من كتر الأبطال ",
  "إحنا نكمل ألف ناقص",
  "المجال بقى حضانة والعيال فرحانة ",
  "بطولك محدش هيطولك",
  "الدنيا ليك وهى شاغلانا عليك",
  "الحب هشوف له بديله عشان أنتم كسر زيرو ",
  "عبادك كدابين اوى يا ربنا ",
  "راحة الكلام فى قلة الكلام",
  "ربنا ما يشمت فينا اللى حاطين عينيهم علينا ",
  "اللى يقلدنا يتحاكم",
  "إمشى وراء الكبير يكبرك",
  "صحابى سالكين بس مش سهلين",
  "ده شايل وده قايل والاثنين عاملين زمايل",
  "كلام وفيس وشات وعلى الأسفلت الحملة مات",
  "بعد المسافة دليل على على الثقافة",
  "أنا بينهم بس مش منهم",
  "فكرتك تمام طلعت دليفرى كلام",
  "هات آخرك ومش هكلمك ولما تخلص هعلمك",
  "اللى هيعوز منك مصلحة هيعملك فى الحر مروحة",
];

// "الشعب و الجيش و الشرطة فى خدمة حمو",
