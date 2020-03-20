Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E518C63F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 05:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgCTEHg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Mar 2020 00:07:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55953 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgCTEHg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Mar 2020 00:07:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02K43d2E084809
        for <linux-ext4@vger.kernel.org>; Fri, 20 Mar 2020 00:07:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yua3wyhkv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Fri, 20 Mar 2020 00:07:34 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 20 Mar 2020 04:07:32 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Mar 2020 04:07:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02K47TKU55509186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 04:07:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 963CA4C05C;
        Fri, 20 Mar 2020 04:07:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B33D04C050;
        Fri, 20 Mar 2020 04:07:28 +0000 (GMT)
Received: from [9.85.72.106] (unknown [9.85.72.106])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Mar 2020 04:07:28 +0000 (GMT)
Subject: Re: Ext4 corruption with VM images as 3 > drop_caches
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>
References: <87pndagw7s.fsf@linux.ibm.com>
 <20200319163613.GA3339@quack2.suse.cz>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Fri, 20 Mar 2020 09:37:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319163613.GA3339@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032004-0008-0000-0000-00000360629C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032004-0009-0000-0000-00004A81C286
Message-Id: <27f3cc91-fd3c-b806-bbd6-fb10b0a86ea0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_10:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200017
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/19/20 10:06 PM, Jan Kara wrote:
> Hi!
> 
> On Wed 18-03-20 09:17:51, Aneesh Kumar K.V wrote:
>> With new vm install I am finding corruption with the vm image if I
>> follow up the install with echo 3 > /proc/sys/vm/drop_caches
>>
>> The file system reports below error.
>>
>> Begin: Running /scripts/local-bottom ... done.
>> Begin: Running /scripts/init-bottom ...
>> [    4.916017] EXT4-fs error (device vda2): ext4_lookup:1700: inode #787185: comm sh: iget: checksum invalid
>> done.
>> [    5.244312] EXT4-fs error (device vda2): ext4_lookup:1700: inode #917954: comm init: iget: checksum invalid
>> [    5.257246] EXT4-fs error (device vda2): ext4_lookup:1700: inode #917954: comm init: iget: checksum invalid
>> /sbin/init: error while loading shared libraries: libc.so.6: cannot open shared object file: Error 74
>> [    5.271207] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>>
>> And debugfs reports
>>
>> debugfs:  stat <917954>
>> Inode: 917954   Type: bad type    Mode:  0000   Flags: 0x0
>> Generation: 0    Version: 0x00000000
>> User:     0   Group:     0   Size: 0
>> File ACL: 0
>> Links: 0   Blockcount: 0
>> Fragment:  Address: 0    Number: 0    Size: 0
>> ctime: 0x00000000 -- Wed Dec 31 18:00:00 1969
>> atime: 0x00000000 -- Wed Dec 31 18:00:00 1969
>> mtime: 0x00000000 -- Wed Dec 31 18:00:00 1969
>> Size of extra inode fields: 0
>> Inode checksum: 0x00000000
>> BLOCKS:
>> debugfs:
>>
>> Bisecting this finds
>> Commit 244adf6426ee31a83f397b700d964cff12a247d3("ext4: make
>> dioread_nolock the default") as bad. If I revert the same on top of linus
>> upstream(fb33c6510d5595144d585aa194d377cf74d31911) I don't hit the
>> corrupttion anymore.
> 
> Thanks for report and the bisection! Is this guest or host kernel that you
> were bisecting? I presume host but I want to make sure.
> 

host kernel. W.r.t guest kernel, it is not dependent on guest kernel 
version. I was able to recreate with different guest kernel versions 
(ubuntu 5.3.0-42-generic kernel and also with upstream)

-aneesh

