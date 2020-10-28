Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6792929E273
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 03:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgJ2COe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 22:14:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbgJ1Vfk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09S4WliL042557;
        Wed, 28 Oct 2020 00:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Zl37AZXairTdHgkwm1QP/KXTOciNg0D8eezgRstoutI=;
 b=AaNyw8FtAIfEbYQItLs37c1l2SwrtWl0uP066o+Tg3bILFUwGW/xohOT5SLA1trp5aLI
 o4TD1qT9GuZsb6wvaPbyFiPyzi3DY47LO1YQJQg+P7dNdAxKD262+4Xl08HydRbppTzz
 W2VkY75BFP51dOhR0ZdQCzxgWwnT1aDkp7b4cpwZOLUlzWkALGV9la8RrRyIRiuUnlWZ
 Q8WlK3hi04WbGrNfaPcHShH6mSMPCMI2rL0YczBoGqWY4JhZzjCzd1Yzq/AD3DrYZSIh
 c+yRXO7vh9PvxGhIAPs/gyzT2v9e86gYnNNJhwmP7U6/Q/pc3vqKDHq1BTaSIbaz6KZM Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ec5ur226-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 00:33:08 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09S4X7Zk043438;
        Wed, 28 Oct 2020 00:33:07 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ec5ur21p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 00:33:07 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09S4Wo2D018174;
        Wed, 28 Oct 2020 04:33:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 34cbw823sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 04:33:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09S4X3b026476964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 04:33:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54F25A4051;
        Wed, 28 Oct 2020 04:33:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFB8BA4040;
        Wed, 28 Oct 2020 04:33:01 +0000 (GMT)
Received: from [9.199.33.247] (unknown [9.199.33.247])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Oct 2020 04:33:01 +0000 (GMT)
Subject: Re: [PATCH] ext4: properly check for dirty state in
 ext4_inode_datasync_dirty()
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20201024140115.GA35973@xps-13-7390>
 <CAD+ocby3hA0GCm5Rf6T3UF+2UWgWoUjrz7=VzbeUMjX6Qx8D5g@mail.gmail.com>
 <da6697a0-4a23-ee68-fa2e-121b3d23c972@linux.ibm.com>
 <CAD+ocbz0NpXYK9fCxpEYGz6fvWJ_SLw+rYQ2yo3UbKJbbEX8hg@mail.gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <f41af253-bd90-805d-a304-71f2f8f454f7@linux.ibm.com>
Date:   Wed, 28 Oct 2020 10:03:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAD+ocbz0NpXYK9fCxpEYGz6fvWJ_SLw+rYQ2yo3UbKJbbEX8hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_01:2020-10-26,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010280023
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 10/28/20 9:18 AM, harshad shirwadkar wrote:
> Actually the simpler fix for this in case of fast commits is to check
> if the inode is on the fast commit list or not. Since we clear the
> fast commit list after every fast and / or full commit, it's always
> true that if the inode is not on the list, that means it isn't dirty.
> This will simplify the logic here and then we can probably get rid of
> i_fc_committed_subtid field altogether. I'll test this and send out a
> patch.

Yes, sounds like a better solution. Thanks!

-ritesh
