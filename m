Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D06D1A7201
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 05:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404935AbgDNDtM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Apr 2020 23:49:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404915AbgDNDtM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Apr 2020 23:49:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E3Xbi9104112
        for <linux-ext4@vger.kernel.org>; Mon, 13 Apr 2020 23:49:11 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30cvwv4bk4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 13 Apr 2020 23:49:11 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 14 Apr 2020 04:48:34 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 04:48:33 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03E3n64J44040392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 03:49:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D64D211C058;
        Tue, 14 Apr 2020 03:49:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CB8211C054;
        Tue, 14 Apr 2020 03:49:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.32.26])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 03:49:06 +0000 (GMT)
Subject: Re: generic/456 regression on 5.7-rc1, 1k test case
To:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
References: <20200413201211.wbcotcr6rg523wzs@localhost.localdomain>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 14 Apr 2020 09:19:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200413201211.wbcotcr6rg523wzs@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041403-0016-0000-0000-000003041CFC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041403-0017-0000-0000-0000336810AB
Message-Id: <20200414034906.5CB8211C054@d06av25.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140027
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Eric,

On 4/14/20 8:22 AM, Ritesh Harjani wrote:
> Hello Eric,
> 
> On 4/14/20 1:42 AM, Eric Whitney wrote:
>> I'm seeing consistent failures for generic/456 while running 
>> kvm-xfstests' 1k
>> test case on 5.7-rc1.  This is with an x86-64 test appliance root file 
>> system
>> image dated 23 March 2020.
>>
>> The test fails when e2fsck reports "inconsistent fs: inode 12, i_size is
>> 147456, should be 163840".
>>
>> Bisecting 5.7-rc1 identified the following patch as the cause:
>> ext4: don't set dioread_nolock by default for blocksize < pagesize
>> (626b035b816b).  Reverting the patch in 5.7-rc1 reliably eliminates 
>> the test
>> failure.
>>
> 
> Since you could reliably reproduce it. Could you please try with this
> patch and see if this fixes it for you?
> 
> https://patchwork.ozlabs.org/project/linux-ext4/patch/20200331105016.8674-1-jack@suse.cz/ 


Ok, so after updating the xfstests to latest, I could reliably reproduce
generic/456 failing on x86 with 1K blocksize on my setup too.
Although, with my limited testing, I couldn't see this issue on Power 
(where blocksize == 4K and PAGESIZE=64K).

But either ways, after applying above patch the tests always passes for
me (tested on x86). So this should indeed fix your reported problem.
Saw an email too that Ted has now picked up this patch.


-ritesh

