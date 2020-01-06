Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857BC130EA9
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2020 09:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgAFIa0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jan 2020 03:30:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgAFIa0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Jan 2020 03:30:26 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0068S7Nt101653
        for <linux-ext4@vger.kernel.org>; Mon, 6 Jan 2020 03:30:24 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb92kt47w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2020 03:30:24 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 6 Jan 2020 08:30:22 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 08:30:21 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0068UKgI34865568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-ext4@vger.kernel.org>; Mon, 6 Jan 2020 08:30:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AC71AE059
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jan 2020 08:30:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EF41AE064
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jan 2020 08:30:20 +0000 (GMT)
Received: from [9.199.159.50] (unknown [9.199.159.50])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jan 2020 08:30:20 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Subject: About BUFFER_TRACE macro in include/linux/jbd2.h
To:     linux-ext4@vger.kernel.org
Date:   Mon, 6 Jan 2020 14:00:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010608-0012-0000-0000-0000037AD0C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010608-0013-0000-0000-000021B6E8FC
Message-Id: <20200106083020.2EF41AE064@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_01:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=1
 clxscore=1031 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060078
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Community,

A very happy new year to all of you!! :)

Had some query on BUFFER_TRACE macro. Here it goes:-

While debugging some issue w.r.t jbd2/bh I came across this empty macro
definition of BUFFER_TRACE in include/linux/jbd2.h.
Though this is called from multiple places, but I could not find any
definition of this as such.

I could see some patches on mailing list which are still calling this
macro. So that means I am definitely missing something here.

Could you please help me understand how can one use this "BUFFER_TRACE"
macro for debugging? I could not find any ftrace event related
to this macro.

For my debugging as of now I ended up creating a file in
include/trace/events/buffer_debug.h and added the definition
of BUFFER_TRACE macro there.

On more googling I did find some old patch which enabled 
CONFIG_BUFFER_DEBUG.
http://people.redhat.com/sct/patches/ext3-2.4/for-2.4.19/98-debug/00-ext3-debug.patch
But this seemed pretty old and I could not find anything latest on this
which is related to above patch.

Any pointers pls?

-ritesh

