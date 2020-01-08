Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE77133F8C
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2020 11:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgAHKpl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jan 2020 05:45:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbgAHKpl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jan 2020 05:45:41 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008AjaDA095709
        for <linux-ext4@vger.kernel.org>; Wed, 8 Jan 2020 05:45:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xd0wjxahv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 08 Jan 2020 05:45:38 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 8 Jan 2020 10:45:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Jan 2020 10:45:22 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 008AjLUE42664070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jan 2020 10:45:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80B2342047;
        Wed,  8 Jan 2020 10:45:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BC4A4203F;
        Wed,  8 Jan 2020 10:45:20 +0000 (GMT)
Received: from [9.199.159.43] (unknown [9.199.159.43])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jan 2020 10:45:20 +0000 (GMT)
Subject: Re: Discussion: is it time to remove dioread_nolock?
To:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
References: <20191226153118.GA17237@mit.edu>
 <9042a8f4-985a-fc83-c059-241c9440200c@linux.alibaba.com>
 <20200106122457.A10F7AE053@d06av26.portsmouth.uk.ibm.com>
 <20200107004338.GB125832@mit.edu> <20200107082212.GA25547@quack2.suse.cz>
 <20200107171109.GB3619@mit.edu> <20200107172236.GJ25547@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 8 Jan 2020 16:15:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200107172236.GJ25547@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010810-0020-0000-0000-0000039EDC00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010810-0021-0000-0000-000021F63B4A
Message-Id: <20200108104520.3BC4A4203F@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_03:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=944
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001080092
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Ted/Jan,

On 1/7/20 10:52 PM, Jan Kara wrote:
> On Tue 07-01-20 12:11:09, Theodore Y. Ts'o wrote:
>> Hmm..... There's actually an even more radical option we could use,
>> given that Ritesh has made dioread_nolock work on block sizes < page
>> size.  We could make dioread_nolock the default, until we can revamp
>> ext4_writepages() to write the data blocks first....

Agreed. I guess it should be a straight forward change to make.
It should be just removing test_opt(inode->i_sb, DIOREAD_NOLOCK) 
condition from ext4_should_dioread_nolock().

> 
> Yes, that's a good point. And I'm not opposed to that if it makes the life
> simpler. But I'd like to see some performance numbers showing how much is
> writeback using unwritten extents slower so that we don't introduce too big
> regression with this...
> 

Yes, let me try to get some performance numbers with dioread_nolock as
the default option for buffered write on my setup.

AFAIU this should also fix the stale data exposure race between DIO
read and ext4_page_mkwrite, since we will by default be using unwritten
extents.
Currently I am testing the patch to fix this race which is based on our 
previous discussion. Will anyway post that. After that I can also 
collect the performance numbers for this suggested option (to make
dioread_nolock as default)


-ritesh

