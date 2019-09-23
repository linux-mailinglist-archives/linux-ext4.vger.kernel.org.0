Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F621BADBA
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2019 08:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392978AbfIWGTO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Sep 2019 02:19:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387519AbfIWGTO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Sep 2019 02:19:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8N6Gqp9007248
        for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2019 02:19:13 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v6mvjp965-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2019 02:19:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 23 Sep 2019 07:19:10 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Sep 2019 07:19:06 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8N6J59D48758964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 06:19:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86F6AA405B;
        Mon, 23 Sep 2019 06:19:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17EA5A405C;
        Mon, 23 Sep 2019 06:19:04 +0000 (GMT)
Received: from [9.199.158.218] (unknown [9.199.158.218])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Sep 2019 06:19:03 +0000 (GMT)
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
Date:   Mon, 23 Sep 2019 11:49:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d264b7b0-334a-eb36-4fdb-5af5526ea4aa@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19092306-0028-0000-0000-000003A15B41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092306-0029-0000-0000-000024636AA3
Message-Id: <20190923061904.17EA5A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=486 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230061
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Finally, I got hold of some HW. I am collecting the numbers as we speak.
> Will post those tomorrow.

I have sent RFC-v2 with comprehensive set of performance numbers and
charts. It could be found below.

https://marc.info/?l=linux-ext4&m=156921748126221&w=2

Please take a look at it.

-ritesh

