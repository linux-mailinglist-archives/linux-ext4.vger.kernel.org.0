Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5FB44D49D
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Nov 2021 11:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhKKKGa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Nov 2021 05:06:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:34269 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhKKKGa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Nov 2021 05:06:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="319086563"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="gz'50?scan'50,208,50";a="319086563"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 02:03:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="gz'50?scan'50,208,50";a="470735282"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2021 02:03:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 02:03:37 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 02:03:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 02:03:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 02:03:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6MhpfpGRsHDMSJpxxYi5bmDH7sHMmDQgmqIVJPyydmFYUP87xbpb0xGYTCz0UWBYeHgcA6EfmLFOFB5qoEup+WrBzpq0PHF+g4UYZUPm+cCbLTnxup4hejJCw5I+8eLY8j37rUHHhqRyuxyOpYNxC/gS+J5dnMz7dd9Xh7fk8HtPG+B3G5teo6PoERHxlhu2XSQ9td+5R/GN+kzOV/0gXxhcf+p3B5TylaIG1iTJgJUDPZyamtcGOz9WqdKLmbqIk3JFrJYswGOa4hpINrmWn5S3qpHldYFOukjkUOR1tUmCs7+aLYZtb1EAE+VjUt8DqSzJdqGSy9RhtFGOCFUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFr9r4BR0nsZS1HYfz0zDJz11gMP8nLFHqfuFhVO1nw=;
 b=cMIL5qQSxKakuSRrJcFBqS4G22Xq0LJBbD7FAmy+C1H5eaXQ8JpLpJkjEpUwti3QPVJ3sQXi3V4PEr44pyDRWDA2RUFPySt5hxkY78p68GQzyzjrWUDV518xhTj4mw9Nn5dBts/uXBUL20p18ehiyn5WqgvW/vEhPYmqWs56uZK6vjHg08wqh+DLIa0RZb9UqyVR+NF4JDq3MTmSjGUeCfp1QsXwV+BvFWU115rTQXq7g5UTwjxyuGj7ivR6/Q8/CbuHkYhJ+rVz1SELJOdpr8XUYi7OSXyu1S1rExFryFCvUGnhnwJgHbRoDjBw0cmt8FVW1TJq+4zYzUmKHZO2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFr9r4BR0nsZS1HYfz0zDJz11gMP8nLFHqfuFhVO1nw=;
 b=OqE3FhzQCC8atI1wEZ5Mrr1hlLDyL7cQA6aFjrh1ezpfgGZtQVQpIDSat2WE502tDK07TCmD/dXctpgX/TY81+O1cVfm+XE4rVL9RzNCMUUltvJE9CNV20h2LKAJi33vATeS99Dml2RGCARwiyJqslS7zmPyDorohQOBg9PJN6A=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5661.namprd11.prod.outlook.com (2603:10b6:a03:3b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 11 Nov
 2021 10:03:29 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4690.019; Thu, 11 Nov 2021
 10:03:29 +0000
Content-Type: multipart/mixed; boundary="------------X5uK2ClJOZCaH7ud0hNWwNQe"
Message-ID: <bd04fa58-e352-1b92-a523-59db5741b273@intel.com>
Date:   Thu, 11 Nov 2021 18:03:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH v2] ext4: fix a possible ABBA deadlock dued to busy PA
References: <202111100102.2XcQrTDQ-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202111100102.2XcQrTDQ-lkp@intel.com>
To:     brookxu <brookxu.cn@gmail.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
X-Forwarded-Message-Id: <202111100102.2XcQrTDQ-lkp@intel.com>
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.77] (192.198.143.18) by HKAPR04CA0002.apcprd04.prod.outlook.com (2603:1096:203:d0::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Thu, 11 Nov 2021 10:03:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68b10f79-52d9-4d21-dad7-08d9a4fa82a1
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5661:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5661588C06C8FA4C4E0AE76CFB949@SJ0PR11MB5661.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIfEV85cpfFRgEL7LnqIGLqb3qQsG7fjkDaVA20lTMAMu4cpZ7/LKNhAjINthmBnIEucS53x42Ey4uCI7F+4g8Cfly6DA10H6EGA3KPLthSE+NpiUeGkI+UqDg0aSdJxyMVyaaiFGaYcvIGjww3BByR/sXbFs7rXUOAo+oUU3jclXXjPCh7lZh9L3QVWUlaRzgAKq/vmmUVNW/lABBUB8/efkqFyb3w2sVRqtrlFAf5Hu5Q/jvmRicLWvvJuxJVFryoAqHTDUnwObG7FfTrVupk4rVSm2SeQhPNp+4Nj697bze6VNELpEsMxSgKHUAJcBsxM1eP4WW24TI1qeIQx9h/sHoiIjie6kJnoI5mzEKuH4KMhHlM859WqleAbLr/f2R37kIKtQH1qHLjwtZhdSd+lbeOVNic9XQNwKohF0tA6+TRRKk9SHq1GQHqGe7afvbxUJSByPnS1s6jkLNBwiaZDYgPjtExXAL3AaM8Pr67TI+CiwSfmCxLOx1Sz4ErbgpQklTFxFAFwhureacW7SJfgnMorxQ7pkwiUkcOjSu+1doH2KJuJJZo5DWsbjGgOql8PW+x5N51MVs+ydkcq3z0SpVDo79e2fyXxv8xxv/DzYt3o7A8WZI6Z0QoXNfoD60160QREQbIR3lPdHyRg84vva2DsmbeUeDbpgF7nDsDScrF/W+mCInlG4GfUyfh595+z6jrVHDkDW8wDjyZvBoGVRVfGu7HtpxkGbiCIHZq2b+P41dWtSgVeRcmatE4StB6/hD52c4jLb5IgyhBDO5Yy820fXuazeT6EY2MMUbqlw4cmR7ukblShK11a1G/h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(316002)(186003)(508600001)(956004)(66946007)(82960400001)(235185007)(33964004)(31696002)(2906002)(16576012)(966005)(31686004)(36756003)(83380400001)(86362001)(6916009)(4001150100001)(8936002)(6666004)(2616005)(6486002)(5660300002)(4326008)(8676002)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWV0Kzk2V3NsbWVHZXVNMTF0d21ZRFRtMnQxL0NrSHVjYmFiMCtjQUY0QmZ3?=
 =?utf-8?B?SGJ2a1lVTHd3Zmx0WGg0VlYrOU9xVHBaZ2ZEeUUrUXJNSkJGaWZQekFuSWhn?=
 =?utf-8?B?M1VJTm8rMUJYMktlUW8wQythZHNTTThXUDAzTnNUcmIvSS82Z0NTV0lwd0x0?=
 =?utf-8?B?dVJHbmsrVDZ6NWJTbVZCai90QktwQ2FOcmdxNkpZRzNGMDFBRVEreHZGNWt2?=
 =?utf-8?B?a3lOUXFUeElMZU9HajRIc1dJSkQ3ejBlN2FYZnJsLzBoL0RDM1JzM3czQ3I5?=
 =?utf-8?B?YkZRUlZUQWVQdkdnU1dGZXRiNUZ4N0dCelkzRitzUkRLSU1xYmdPQnc5bUlu?=
 =?utf-8?B?dy93d1Roa2RzNFI2Y0tmVEJFdXNXUis1dUxNYUJBZ0NHOWN1UTNIRUl5TmNq?=
 =?utf-8?B?Z0xWUEpWRW81NkpmeGFvcTg4KzNaQndFcUs5QUgvcUFlUjlKdzB3aTkzNHpX?=
 =?utf-8?B?SjlvMHlXam4wbUJSdXp1dU5jbk5wZEk5VFZsR1VnUExieUpYTnVTQllKcTRa?=
 =?utf-8?B?dWxwT1pCWHlBN3NUUzZ0TlNFdU9kcGdsazZwZ25MSDczTktyUHNvYlp1T1hk?=
 =?utf-8?B?b0RqOC9QK01nZW1RTzhSSnRoS3N2bjF1bjQwK2l1NGF4Qyt1aGUvVzFqZ2h6?=
 =?utf-8?B?eU5BQUZMd1pJYXZ1V1lQbERWcEY3bWJqZTUrMXh0dmRvS3g2bVhXYXVUbUJN?=
 =?utf-8?B?N2RUM09xTlkrOE5MZmF3eWltb0Fydnk4blZYd2tUV3AwZWU3VUU0Z2IyM1Iz?=
 =?utf-8?B?QVVGWUh4cGEwRW9LclE1bXc4NUptTy9JMUJ0T3FIWXNwUnVvclh6SUxVVWd5?=
 =?utf-8?B?c3pVV2dXQm91NG1STExNOEpMcFlVQi9VV0xkVDdnNi90WUgzczNuaXBjUlJU?=
 =?utf-8?B?RUQrUmFKemtkUXR0T1lLRGdZVUdRYVJjYmxNaGVuVCtsalpCRnJJaUk4ZHhS?=
 =?utf-8?B?dlFNZXZ3L0d4ZU5YUndBcnF6cjNLTmtudU5QOUFwd0RCN2ZYcjVtWHEzNDlW?=
 =?utf-8?B?ZWU1NVd0WklndjVGQitheDM2OTF1Tk9pZzlWeU5hUTdoeEg1Ukt2TENQSkdi?=
 =?utf-8?B?bWlxQWZJQzNxMXFsUnZFSlk3TWkwaXhSSXRyMjJ1dHJIbEs2NVgweU1IWGdT?=
 =?utf-8?B?L1F6MTRSWHI1KzJWNkVtQ0FKN292NXVPRnFCbVpRL0JJMXF0RVRJYStlUm5x?=
 =?utf-8?B?ellxR1VvdjhlSUdRVVl5MGlOZzREQk5sZ0V2MUJuaE4yS01nTitnRi9CVmR4?=
 =?utf-8?B?cGV0OTVQMWl0cm9Uc0xoOUhsQlMrOVlCaDd2TGRGcjdwM1dkb0VnUW41VzZR?=
 =?utf-8?B?NUtCSFMzSDZOdEdXbkpvb1huT1FKNXBIb2pZOVV4SWdhbE1TUFhyS0RCdkhM?=
 =?utf-8?B?YW96QWRZaEUrYWNKb2w1NGhYb1JYd0NIRlgxRWIyK3EzeWtVVVhML3pmUGkz?=
 =?utf-8?B?RTFjKzZiUWdNNzQrM2JuVHZCL0VBSGxUSmU3MWZTK2pZc0NIRk1pS1h0VHVK?=
 =?utf-8?B?ZFkzSmkwcy9NdVF4aWg4VXRzM0V0U1ViYUFHSTVqN3hWN1M1Z0JMZWhDYVc1?=
 =?utf-8?B?WnZHeXg0bWlLMUpWNmVJSnZWY2w1Uk5QdzExcms1S3ZLRHprWVk1NU5YWFl0?=
 =?utf-8?B?UGhFM1F3NHUyTEdER0VwR21zNE4vWjFoN0FNeVh5cGt1aUdFTVl5N1NhL3Fo?=
 =?utf-8?B?b3hHbkx5dmFzakZBdzYyZGZ1OEtCV3NTcEh2STFsZkQ0emRCRnptSGQ5ZmdU?=
 =?utf-8?B?NjBtbVhMb3A5bHYxODlJU05JNzAzOFpCZ3BvT0JGUGNjczZhOGlVUlUvUzhE?=
 =?utf-8?B?am84T1pNeGRSb3Z0ZEt5L0s1RkhXQ3lSNmxDaUJCZi82bTEyQWZNSUxzVlg2?=
 =?utf-8?B?TVYrVFF3OWdqTEhZTWkvdzBNdmJzRTFFUGpvRnJ5b2NyNkRhdFZ0Tm1XUnE5?=
 =?utf-8?B?bEV2QytWY0c4a1M4WUNUeFhHb085bVVXQ1F6SW5mNGMvZ0lxVlQ2M3lUWFYw?=
 =?utf-8?B?UkoxS3RWUkhjSDF4eHN3d3o0MkY3VWMrb2V4ZlVqYzlLVkZqVTIzQWowaTB0?=
 =?utf-8?B?WmVWZ2pXZUZ1Y2RuemJKZFI2OVhaSDJkU1J2Q0hjU3ZOV09OTEt1NlFPeUVJ?=
 =?utf-8?B?alRZaWNxY2dJdVlFSFBlRGNMTTNldkFNSVlDd0E5MFdYSW1aU2JhUzFmbDVn?=
 =?utf-8?Q?I3Ijj2NJ7ESTupnrA66fGss=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b10f79-52d9-4d21-dad7-08d9a4fa82a1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 10:03:29.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdjjfgmUBgOHWgtLKIw14YBPndb3kuINePdtPYC8MOtPOI13KjMMS/ra3MN/1hEaf4rmdk4XPdjFVDYqGFvLYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5661
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--------------X5uK2ClJOZCaH7ud0hNWwNQe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chunguang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on v5.15 next-20211109]
[cannot apply to tytso-fscrypt/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/brookxu/ext4-fix-a-possible-ABBA-deadlock-dued-to-busy-PA/20210929-091410
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: i386-randconfig-c001-20210929 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/0day-ci/linux/commit/5e956ecab47126f1d065a1ac6e6d5077e02e6f87
         git remote add linux-review https://github.com/0day-ci/linux
         git fetch --no-tags linux-review brookxu/ext4-fix-a-possible-ABBA-deadlock-dued-to-busy-PA/20210929-091410
         git checkout 5e956ecab47126f1d065a1ac6e6d5077e02e6f87
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/ext4/mballoc.c:4849:3: warning: Value stored to 'needed' is never read [clang-analyzer-deadcode.DeadStores]
                    needed = EXT4_CLUSTERS_PER_GROUP(sb) + 1;
                    ^

vim +/needed +4849 fs/ext4/mballoc.c

c9de560ded61faa Alex Tomas            2008-01-29  4805
c9de560ded61faa Alex Tomas            2008-01-29  4806  /*
c9de560ded61faa Alex Tomas            2008-01-29  4807   * releases all preallocations in given group
c9de560ded61faa Alex Tomas            2008-01-29  4808   *
c9de560ded61faa Alex Tomas            2008-01-29  4809   * first, we need to decide discard policy:
c9de560ded61faa Alex Tomas            2008-01-29  4810   * - when do we discard
c9de560ded61faa Alex Tomas            2008-01-29  4811   *   1) ENOSPC
c9de560ded61faa Alex Tomas            2008-01-29  4812   * - how many do we discard
c9de560ded61faa Alex Tomas            2008-01-29  4813   *   1) how many requested
c9de560ded61faa Alex Tomas            2008-01-29  4814   */
4ddfef7b41aebbb Eric Sandeen          2008-04-29  4815  static noinline_for_stack int
4ddfef7b41aebbb Eric Sandeen          2008-04-29  4816  ext4_mb_discard_group_preallocations(struct super_block *sb,
5e956ecab47126f Chunguang Xu          2021-09-29  4817  				     ext4_group_t group, int needed, int *busy)
c9de560ded61faa Alex Tomas            2008-01-29  4818  {
c9de560ded61faa Alex Tomas            2008-01-29  4819  	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
c9de560ded61faa Alex Tomas            2008-01-29  4820  	struct buffer_head *bitmap_bh = NULL;
c9de560ded61faa Alex Tomas            2008-01-29  4821  	struct ext4_prealloc_space *pa, *tmp;
c9de560ded61faa Alex Tomas            2008-01-29  4822  	struct list_head list;
c9de560ded61faa Alex Tomas            2008-01-29  4823  	struct ext4_buddy e4b;
c9de560ded61faa Alex Tomas            2008-01-29  4824  	int err;
5e956ecab47126f Chunguang Xu          2021-09-29  4825  	int free = 0;
c9de560ded61faa Alex Tomas            2008-01-29  4826
d3df14535f4a5b5 Ritesh Harjani        2020-05-10  4827  	mb_debug(sb, "discard preallocation for group %u\n", group);
c9de560ded61faa Alex Tomas            2008-01-29  4828  	if (list_empty(&grp->bb_prealloc_list))
bbc4ec77e9f9c7a Ritesh Harjani        2020-05-10  4829  		goto out_dbg;
c9de560ded61faa Alex Tomas            2008-01-29  4830
574ca174c97f790 Theodore Ts'o         2008-07-11  4831  	bitmap_bh = ext4_read_block_bitmap(sb, group);
9008a58e5dcee01 Darrick J. Wong       2015-10-17  4832  	if (IS_ERR(bitmap_bh)) {
9008a58e5dcee01 Darrick J. Wong       2015-10-17  4833  		err = PTR_ERR(bitmap_bh);
54d3adbc29f0c7c Theodore Ts'o         2020-03-28  4834  		ext4_error_err(sb, -err,
54d3adbc29f0c7c Theodore Ts'o         2020-03-28  4835  			       "Error %d reading block bitmap for %u",
9008a58e5dcee01 Darrick J. Wong       2015-10-17  4836  			       err, group);
bbc4ec77e9f9c7a Ritesh Harjani        2020-05-10  4837  		goto out_dbg;
c9de560ded61faa Alex Tomas            2008-01-29  4838  	}
c9de560ded61faa Alex Tomas            2008-01-29  4839
c9de560ded61faa Alex Tomas            2008-01-29  4840  	err = ext4_mb_load_buddy(sb, group, &e4b);
ce89f46cb833f89 Aneesh Kumar K.V      2008-07-23  4841  	if (err) {
9651e6b2e20648d Konstantin Khlebnikov 2017-05-21  4842  		ext4_warning(sb, "Error %d loading buddy information for %u",
9651e6b2e20648d Konstantin Khlebnikov 2017-05-21  4843  			     err, group);
ce89f46cb833f89 Aneesh Kumar K.V      2008-07-23  4844  		put_bh(bitmap_bh);
bbc4ec77e9f9c7a Ritesh Harjani        2020-05-10  4845  		goto out_dbg;
ce89f46cb833f89 Aneesh Kumar K.V      2008-07-23  4846  	}
c9de560ded61faa Alex Tomas            2008-01-29  4847
c9de560ded61faa Alex Tomas            2008-01-29  4848  	if (needed == 0)
7137d7a48e2213e Theodore Ts'o         2011-09-09 @4849  		needed = EXT4_CLUSTERS_PER_GROUP(sb) + 1;
c9de560ded61faa Alex Tomas            2008-01-29  4850
c9de560ded61faa Alex Tomas            2008-01-29  4851  	INIT_LIST_HEAD(&list);
c9de560ded61faa Alex Tomas            2008-01-29  4852  	ext4_lock_group(sb, group);
c9de560ded61faa Alex Tomas            2008-01-29  4853  	list_for_each_entry_safe(pa, tmp,
c9de560ded61faa Alex Tomas            2008-01-29  4854  				&grp->bb_prealloc_list, pa_group_list) {
c9de560ded61faa Alex Tomas            2008-01-29  4855  		spin_lock(&pa->pa_lock);
c9de560ded61faa Alex Tomas            2008-01-29  4856  		if (atomic_read(&pa->pa_count)) {
c9de560ded61faa Alex Tomas            2008-01-29  4857  			spin_unlock(&pa->pa_lock);
5e956ecab47126f Chunguang Xu          2021-09-29  4858  			*busy = 1;
c9de560ded61faa Alex Tomas            2008-01-29  4859  			continue;
c9de560ded61faa Alex Tomas            2008-01-29  4860  		}
c9de560ded61faa Alex Tomas            2008-01-29  4861  		if (pa->pa_deleted) {
c9de560ded61faa Alex Tomas            2008-01-29  4862  			spin_unlock(&pa->pa_lock);
c9de560ded61faa Alex Tomas            2008-01-29  4863  			continue;
c9de560ded61faa Alex Tomas            2008-01-29  4864  		}
c9de560ded61faa Alex Tomas            2008-01-29  4865
c9de560ded61faa Alex Tomas            2008-01-29  4866  		/* seems this one can be freed ... */
27bc446e2def38d brookxu               2020-08-17  4867  		ext4_mb_mark_pa_deleted(sb, pa);
c9de560ded61faa Alex Tomas            2008-01-29  4868
70022da804f0f3f Ye Bin                2020-09-16  4869  		if (!free)
70022da804f0f3f Ye Bin                2020-09-16  4870  			this_cpu_inc(discard_pa_seq);
70022da804f0f3f Ye Bin                2020-09-16  4871
c9de560ded61faa Alex Tomas            2008-01-29  4872  		/* we can trust pa_free ... */
c9de560ded61faa Alex Tomas            2008-01-29  4873  		free += pa->pa_free;
c9de560ded61faa Alex Tomas            2008-01-29  4874
c9de560ded61faa Alex Tomas            2008-01-29  4875  		spin_unlock(&pa->pa_lock);
c9de560ded61faa Alex Tomas            2008-01-29  4876
c9de560ded61faa Alex Tomas            2008-01-29  4877  		list_del(&pa->pa_group_list);
c9de560ded61faa Alex Tomas            2008-01-29  4878  		list_add(&pa->u.pa_tmp_list, &list);
c9de560ded61faa Alex Tomas            2008-01-29  4879  	}
c9de560ded61faa Alex Tomas            2008-01-29  4880
c9de560ded61faa Alex Tomas            2008-01-29  4881  	/* now free all selected PAs */
c9de560ded61faa Alex Tomas            2008-01-29  4882  	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
c9de560ded61faa Alex Tomas            2008-01-29  4883
c9de560ded61faa Alex Tomas            2008-01-29  4884  		/* remove from object (inode or locality group) */
c9de560ded61faa Alex Tomas            2008-01-29  4885  		spin_lock(pa->pa_obj_lock);
c9de560ded61faa Alex Tomas            2008-01-29  4886  		list_del_rcu(&pa->pa_inode_list);
c9de560ded61faa Alex Tomas            2008-01-29  4887  		spin_unlock(pa->pa_obj_lock);
c9de560ded61faa Alex Tomas            2008-01-29  4888
cc0fb9ad7dbc5a1 Aneesh Kumar K.V      2009-03-27  4889  		if (pa->pa_type == MB_GROUP_PA)
3e1e5f501632460 Eric Sandeen          2010-10-27  4890  			ext4_mb_release_group_pa(&e4b, pa);
c9de560ded61faa Alex Tomas            2008-01-29  4891  		else
3e1e5f501632460 Eric Sandeen          2010-10-27  4892  			ext4_mb_release_inode_pa(&e4b, bitmap_bh, pa);
c9de560ded61faa Alex Tomas            2008-01-29  4893
c9de560ded61faa Alex Tomas            2008-01-29  4894  		list_del(&pa->u.pa_tmp_list);
c9de560ded61faa Alex Tomas            2008-01-29  4895  		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
c9de560ded61faa Alex Tomas            2008-01-29  4896  	}
c9de560ded61faa Alex Tomas            2008-01-29  4897
c9de560ded61faa Alex Tomas            2008-01-29  4898  	ext4_unlock_group(sb, group);
e39e07fdfd98be8 Jing Zhang            2010-05-14  4899  	ext4_mb_unload_buddy(&e4b);
c9de560ded61faa Alex Tomas            2008-01-29  4900  	put_bh(bitmap_bh);
bbc4ec77e9f9c7a Ritesh Harjani        2020-05-10  4901  out_dbg:
d3df14535f4a5b5 Ritesh Harjani        2020-05-10  4902  	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
5e956ecab47126f Chunguang Xu          2021-09-29  4903  		 free, group, grp->bb_free);
5e956ecab47126f Chunguang Xu          2021-09-29  4904  	return free;
c9de560ded61faa Alex Tomas            2008-01-29  4905  }
c9de560ded61faa Alex Tomas            2008-01-29  4906

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------X5uK2ClJOZCaH7ud0hNWwNQe
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
yh3xCeB7VvNzHLhfK7OP/wMYj0iL7joCAA==

--------------X5uK2ClJOZCaH7ud0hNWwNQe--
