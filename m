Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49013B557
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 23:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANWd4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 17:33:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727072AbgANWd4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Jan 2020 17:33:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EMWQnp023554
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2020 17:33:55 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xh7h7u3s7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2020 17:33:55 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 14 Jan 2020 22:33:54 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Jan 2020 22:33:52 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00EMX26c34210190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 22:33:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 557BEA4093;
        Tue, 14 Jan 2020 22:33:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25E7DA4094;
        Tue, 14 Jan 2020 22:33:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.44.28])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jan 2020 22:33:49 +0000 (GMT)
Subject: Re: [RFC 0/2] ext4: Fix stale data read exposure problem with DIO
 read/page_mkwrite
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        darrick.wong@oracle.com
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <20200114163945.GC7127@infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 15 Jan 2020 04:03:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200114163945.GC7127@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011422-0008-0000-0000-000003496301
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011422-0009-0000-0000-00004A69B72A
Message-Id: <20200114223350.25E7DA4094@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001140173
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 1/14/20 10:09 PM, Christoph Hellwig wrote:
>> Currently there is a small race window as pointed out by Jan [2] where, when
>> ext4 tries to allocate a written block for mapped files and if DIO read is in
>> progress, then this may result into stale data read exposure problem.
> 
> Do we have a test case for the problem?

I am not very sure if we have it in xfstests, (since I guess, DIO read 
during mmap writes is not well supported anyways).
But sure I was anyway thinking of writing one for my unit testing. Till
now I was mainly following that theoretically it is possible, although
it may be hard to catch it practically.


> Please add at very least the fsdevel and xfs lists to iomap patches.

Yes, sorry about that. Will cc' in next time.


-ritesh

