Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A001B8419
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Apr 2020 09:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDYHDq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Apr 2020 03:03:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgDYHDp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 25 Apr 2020 03:03:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03P71PgF191136
        for <linux-ext4@vger.kernel.org>; Sat, 25 Apr 2020 03:03:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30mfknryt1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Sat, 25 Apr 2020 03:03:44 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Sat, 25 Apr 2020 08:02:51 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 25 Apr 2020 08:02:47 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03P72Uvn63373764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Apr 2020 07:02:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CCAA4C04A;
        Sat, 25 Apr 2020 07:03:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B43334C046;
        Sat, 25 Apr 2020 07:03:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.185.245])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 25 Apr 2020 07:03:35 +0000 (GMT)
Subject: Re: [PATCH 1/2] fibmap: Warn and return an error in case of block >
 INT_MAX
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
 <20200424191739.GA217280@gmail.com>
 <20200424225425.6521D4C040@d06av22.portsmouth.uk.ibm.com>
 <20200424234058.GA29705@bombadil.infradead.org>
 <20200424234647.GX6749@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 25 Apr 2020 12:33:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200424234647.GX6749@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042507-0016-0000-0000-0000030A76BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042507-0017-0000-0000-0000336EA013
Message-Id: <20200425070335.B43334C046@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-25_01:2020-04-24,2020-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004250054
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 4/25/20 5:16 AM, Darrick J. Wong wrote:
> On Fri, Apr 24, 2020 at 04:40:58PM -0700, Matthew Wilcox wrote:
>> On Sat, Apr 25, 2020 at 04:24:24AM +0530, Ritesh Harjani wrote:
>>> Ok, I see.
>>> Let me replace WARN() with below pr_warn() line then. If no objections,
>>> then will send this in a v2 with both patches combined as Darrick
>>> suggested. - (with Reviewed-by tags of Jan & Christoph).
>>>
>>> pr_warn("fibmap: this would truncate fibmap result\n");
>>
>> We generally don't like userspace to be able to trigger kernel messages
>> on demand, so they can't swamp the logfiles.  printk_ratelimited()?
> 
> Or WARN_ON_ONCE...

So, Eric was mentioning WARN_** are mostly for kernel side of bugs.
But this is mostly a API fault which affects user side and also to
warn the user about the possible truncation in the block fibmap
addr.
Also WARN_ON_ONCE, will be shown only once and won't be printed for
every other file for which block addr > INT_MAX.

I think we could go with below. If ok, I could post this in v2.

pr_warn_ratelimited("fibmap: would truncate fibmap result\n");

-ritesh

