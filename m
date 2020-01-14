Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C8913B5E1
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2020 00:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgANXbD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 18:31:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728650AbgANXbC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Jan 2020 18:31:02 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ENRN6m126518
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2020 18:31:02 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhfexhqp5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2020 18:31:01 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 14 Jan 2020 23:30:59 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Jan 2020 23:30:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00ENU7S026149288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 23:30:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB7DBA404D;
        Tue, 14 Jan 2020 23:30:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 890D7A4040;
        Tue, 14 Jan 2020 23:30:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.44.28])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jan 2020 23:30:54 +0000 (GMT)
Subject: Re: Discussion: is it time to remove dioread_nolock?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
References: <20200109163802.GA33929@mit.edu>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 15 Jan 2020 05:00:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200109163802.GA33929@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011423-0020-0000-0000-000003A0B206
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011423-0021-0000-0000-000021F828F8
Message-Id: <20200114233054.890D7A4040@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140182
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 1/9/20 10:08 PM, Theodore Y. Ts'o wrote:
> On Thu, Jan 09, 2020 at 02:51:42PM +0530, Ritesh Harjani wrote:
>>> Dbench was slightly impacted; I didn't see any real differences with
>>> compilebench or postmark.  dioread_nolock did improve fio with
>>> sequential reads; which is interesting, since I would have expected
>>
>> IIUC, this Seq. read numbers are with --direct=1 & bs=2MB & ioengine=libaio,
>> correct?
>> So essentially it will do a DIO AIO sequential read.
> 
> Correct.

I too collected some performance numbers on my x86 box with
--direct=1, bs=4K/1M & ioengine=libaio, with default opt v/s 
dioread_nolock opt on latest ext4 git tree.

I found the delta to be within +/- 6% in all of the runs which includes, 
seq read, mixed rw & mixed randrw.

-ritesh

