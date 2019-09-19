Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12611B8107
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2019 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404330AbfISSsw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Sep 2019 14:48:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404283AbfISSsw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Sep 2019 14:48:52 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8JIlSmO179755
        for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2019 14:48:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v4ch3xgr8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2019 14:48:49 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 19 Sep 2019 19:48:47 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Sep 2019 19:48:43 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8JImgQa27459590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 18:48:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B0A34C044;
        Thu, 19 Sep 2019 18:48:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88D2F4C050;
        Thu, 19 Sep 2019 18:48:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Sep 2019 18:48:40 +0000 (GMT)
Subject: Re: [RFC 0/2] ext4: Improve locking sequence in DIO write path
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, jack@suse.cz,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, adilger@dilger.ca,
        mbobrowski@mbobrowski.org, rgoldwyn@suse.de
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
 <d1f3b048-d21c-67f1-09a3-dd2abf7c156d@linux.alibaba.com>
 <20190918100336.3A4DA11C050@d06av25.portsmouth.uk.ibm.com>
 <d264b7b0-334a-eb36-4fdb-5af5526ea4aa@linux.alibaba.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 20 Sep 2019 00:18:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d264b7b0-334a-eb36-4fdb-5af5526ea4aa@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091918-0012-0000-0000-0000034E379D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091918-0013-0000-0000-00002188BACE
Message-Id: <20190919184840.88D2F4C050@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190156
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On 9/19/19 7:38 AM, Joseph Qi wrote:
> 
> 
> On 19/9/18 18:03, Ritesh Harjani wrote:
>> Hello Joseph,
>>
>> First of all thanks a lot for collecting a thorough
>> performance numbers.
>>
>> On 9/18/19 12:05 PM, Joseph Qi wrote:
>>> Hi Ritesh,
>>>
>>> On 19/9/17 18:32, Ritesh Harjani wrote:
>>>> Hello,
>>>>
>>>> This patch series is based on the upstream discussion with Jan
>>>> & Joseph @ [1].
>>>> It is based on top of Matthew's v3 ext4 iomap patch series [2]
>>>>
>>>> Patch-1: Adds the ext4_ilock/unlock APIs and also replaces all
>>>> inode_lock/unlock instances from fs/ext4/*
>>>>
>>>> For now I already accounted for trylock/lock issue symantics
>>>> (which was discussed here [3]) in the same patch,
>>>> since the this whole patch was around inode_lock/unlock API,
>>>> so I thought it will be best to address that issue in the same patch.
>>>> However, kindly let me know if otherwise.
>>>>
>>>> Patch-2: Commit msg of this patch describes in detail about
>>>> what it is doing.
>>>> In brief - we try to first take the shared lock (instead of exclusive
>>>> lock), unless it is a unaligned_io or extend_io. Then in
>>>> ext4_dio_write_checks(), if we start with shared lock, we see
>>>> if we can really continue with shared lock or not. If not, then
>>>> we release the shared lock then acquire exclusive lock
>>>> and restart ext4_dio_write_checks().
>>>>
>>>>
>>>> Tested against few xfstests (with dioread_nolock mount option),
>>>> those ran fine (ext4 & generic).
>>>>
>>>> I tried testing performance numbers on my VM (since I could not get
>>>> hold of any real h/w based test device). I could test the fact
>>>> that earlier we were trying to do downgrade_write() lock, but with
>>>> this patch, that path is now avoided for fio test case
>>>> (as reported by Joseph in [4]).
>>>> But for the actual results, I am not sure if VM machine testing could
>>>> really give the reliable perf numbers which we want to take a look at.
>>>> Though I do observe some form of perf improvements, but I could not
>>>> get any reliable numbers (not even with the same list of with/without
>>>> patches with which Joseph posted his numbers [1]).
>>>>
>>>>
>>>> @Joseph,
>>>> Would it be possible for you to give your test case a run with this
>>>> patches? That will be really helpful.
>>>>
>>>> Branch for this is hosted at below tree.
>>>>
>>>> https://github.com/riteshharjani/linux/tree/ext4-ilock-RFC
>>>>
>>> I've tested your branch, the result is:
>>> mounting with dioread_nolock, it behaves the same like reverting
>>> parallel dio reads + dioread_nolock;
>>
>> Good sign, means that patch is doing what it is supposed to do.
>>
>>
>>> while mounting without dioread_nolock, no improvement, or even worse.
>>> Please refer the test data below.
>> Actually without dioread_nolock, we take the restart path.
>> i.e. initially we start with SHARED_LOCK, but if dioread_nolock
>> is not enabled (or check some other conditions like overwrite),
>> we release the shared lock and re-acquire the EXCL lock.
>>
>>
>> But as an optimization, I added the below diff just now
>> to directly first check for ext4_should_dioread_nolock too
>> before taking the shared lock.
>>
>> I think with this we should not see any performance regression
>> (even without dioread_nolock mount option).
>> Since it will directly start with exclusive lock
>> if dioread_nolock mount option is not enabled.
>>
>> I have updated the tree with this diff in same branch.
>>
>>
>> ext4_dio_file_write_iter ()
>> <...>
>>
>> 498         if (iolock == EXT4_IOLOCK_SHARED && !ext4_should_dioread_nolock(inode))
>> 499                 iolock = EXT4_IOLOCK_EXCL;
>> 500
>> <...>
>>
> With this optimization, when mounting without dioread_nolock, it has
> a little improvement compared to the last ilock version, but still
> poor than original, especially for big block size.

Finally, I got hold of some HW. I am collecting the numbers as we speak.
Will post those tomorrow.

Thanks for your help!!

-ritesh



> 
> w/        = with parallel dio reads (original)
> w/o       = reverting parallel dio reads
> w/o+      = reverting parallel dio reads + dioread_nolock
> ilock     = ext4-ilock-RFC
> ilock+    = ext4-ilock-RFC + dioread_nolock
> ilocknew  = ext4-ilock-RFC latest
> ilocknew+ = ext4-ilock-RFC latest + dioread_nolock
> 
> 
> bs=4k:
> ------------------------------------------------------------------
>            |            READ           |           WRITE          |
> ------------------------------------------------------------------
> w/        | 30898KB/s,7724,555.00us   | 30875KB/s,7718,479.70us  |
> ------------------------------------------------------------------
> w/o       | 117915KB/s,29478,248.18us | 117854KB/s,29463,21.91us |
> ------------------------------------------------------------------
> w/o+      | 123450KB/s,30862,245.77us | 123368KB/s,30841,12.14us |
> ------------------------------------------------------------------
> ilock     | 29964KB/s,7491,326.70us   | 29940KB/s,7485,740.62us  |
> ------------------------------------------------------------------
> ilocknew  | 30190KB/s,7547,497.47us   | 30159KB/s,7539,561.85us  |
> ------------------------------------------------------------------
> ilock+    | 123685KB/s,30921,245.52us | 123601KB/s,30900,12.11us |
> ------------------------------------------------------------------
> ilocknew+ | 123169KB/s,30792,245.81us | 123087KB/s,30771,12.85us |
> ------------------------------------------------------------------
> 
> 
> bs=16k:
> ------------------------------------------------------------------
>            |            READ           |           WRITE          |
> ------------------------------------------------------------------
> w/        | 58961KB/s,3685,835.28us   | 58877KB/s,3679,1335.98us |
> ------------------------------------------------------------------
> w/o       | 218409KB/s,13650,554.46us | 218257KB/s,13641,29.22us |
> ------------------------------------------------------------------
> w/o+      | 222477KB/s,13904,552.94us | 222322KB/s,13895,20.28us |
> ------------------------------------------------------------------
> ilock     | 56039KB/s,3502,632.96us   | 55943KB/s,3496,1652.72us |
> ------------------------------------------------------------------
> ilocknew  | 57317KB/s,3582,1023.88us  | 57230KB/s,3576,1209.91us |
> ------------------------------------------------------------------
> ilock+    | 222747KB/s,13921,552.57us | 222592KB/s,13912,20.31us |
> ------------------------------------------------------------------
> ilocknew+ | 221945KB/s,13871,552.61us | 221791KB/s,13861,21.29us |
> ------------------------------------------------------------------
> 
> bs=64k
> -------------------------------------------------------------------
>            |            READ           |           WRITE           |
> -------------------------------------------------------------------
> w/        | 119396KB/s,1865,1759.38us | 119159KB/s,1861,2532.26us |
> -------------------------------------------------------------------
> w/o       | 422815KB/s,6606,1146.05us | 421619KB/s,6587,60.72us   |
> --------------------------------------------,----------------------
> w/o+      | 427406KB/s,6678,1141.52us | 426197KB/s,6659,52.79us   |
> -------------------------------------------------------------------
> ilock     | 105800KB/s,1653,1451.68us | 105721KB/s,1651,3388.64us |
> -------------------------------------------------------------------
> ilocknew  | 107447KB/s,1678,1654.33us | 107322KB/s,1676,3112.96us |
> -------------------------------------------------------------------
> ilock+    | 427678KB/s,6682,1142.13us | 426468KB/s,6663,52.31us   |
> -------------------------------------------------------------------
> ilocknew+ | 427054KB/s,6672,1143.43us | 425846KB/s,6653,52.87us   |
> -------------------------------------------------------------------
> 
> bs=512k
> -------------------------------------------------------------------
>            |            READ           |           WRITE           |
> -------------------------------------------------------------------
> w/        | 392973KB/s,767,5046.35us  | 393165KB/s,767,5359.86us  |
> -------------------------------------------------------------------
> w/o       | 590266KB/s,1152,4312.01us | 590554KB/s,1153,2606.82us |
> -------------------------------------------------------------------
> w/o+      | 618752KB/s,1208,4125.82us | 619054KB/s,1209,2487.90us |
> -------------------------------------------------------------------
> ilock     | 296239KB/s,578,4703.10us  | 296384KB/s,578,9049.32us  |
> -------------------------------------------------------------------
> ilocknew  | 309740KB/s,604,5485.93us  | 309892KB/s,605,7666.79us  |
> -------------------------------------------------------------------
> ilock+    | 616636KB/s,1204,4143.38us | 616937KB/s,1204,2490.08us |
> -------------------------------------------------------------------
> ilocknew+ | 618159KB/s,1207,4129.76us | 618461KB/s,1207,2486.90us |
> -------------------------------------------------------------------
> 
> bs=1M
> -------------------------------------------------------------------
>            |            READ           |           WRITE           |
> -------------------------------------------------------------------
> w/        | 487779KB/s,476,8058.55us  | 485592KB/s,474,8630.51us  |
> -------------------------------------------------------------------
> w/o       | 593927KB/s,580,7623.63us  | 591265KB/s,577,6163.42us  |
> -------------------------------------------------------------------
> w/o+      | 615011KB/s,600,7399.93us  | 612255KB/s,597,5936.61us  |
> -------------------------------------------------------------------
> ilock     | 394762KB/s,385,7097.55us  | 392993KB/s,383,13626.98us |
> -------------------------------------------------------------------
> ilocknew  | 422052KB/s,412,8338.16us  | 420161KB/s,410,11008.95us |
> -------------------------------------------------------------------
> ilock+    | 626183KB/s,611,7319.16us  | 623377KB/s,608,5773.24us  |
> -------------------------------------------------------------------
> ilocknew+ | 626006KB/s,611,7281.09us  | 623200KB/s,608,5817.84us  |
> -------------------------------------------------------------------
> 

