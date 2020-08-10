Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9838824037F
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 10:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgHJIjH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Aug 2020 04:39:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgHJIjH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 Aug 2020 04:39:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07A8W8o3080791;
        Mon, 10 Aug 2020 04:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=VvaSZcZ55zcKkEkGlqKbwmfJv9CMAQpb13cLvAi69Is=;
 b=kKjjBCUW/VrpGdNb/CiTBTSItJvNLm0drnmysemJmA7FhZtAoVeo+sGvwD3INFtMw9tS
 c7VbnDsezbNVZ2d2oDPExX/iGoCPelW0iplf3QvkJ627rWMGNce4YFFnGyoa+gCLLfgk
 MpQeJ6AxbZK9+SUDBj2Px/usywNs9NJv9Eq+ogVgliomeiCAXND4D8JzMyF0xy2kI6lq
 RhCdK9UYGjB8WorAzi9cDpok0xmtkTCf2A8u1XIm0p4clt1eouxOx7a4FCxh83+M2Gqu
 QKHxtsGX2/05/naEqZMZcAQ8MfZSvv2wt6vSVoBbjsr9KfadYxVtPGzEZlMbVMyIzueI lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32sr7udj3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 04:39:03 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07A8WUZm081648;
        Mon, 10 Aug 2020 04:39:02 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32sr7udj35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 04:39:02 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07A8Wijf027472;
        Mon, 10 Aug 2020 08:39:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 32skaha24h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 08:39:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07A8cwSi27984270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 08:38:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5967BAE057;
        Mon, 10 Aug 2020 08:38:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90732AE045;
        Mon, 10 Aug 2020 08:38:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Aug 2020 08:38:57 +0000 (GMT)
Subject: Re: [PATCH] ext4: remove unused parameter of
 ext4_generic_delete_entry function
To:     Kyoungho Koo <rnrudgh@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
References: <20200810080701.GA14160@koo-Z370-HD3>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 10 Aug 2020 14:08:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200810080701.GA14160@koo-Z370-HD3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200810083857.90732AE045@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_03:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100057
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/10/20 1:37 PM, Kyoungho Koo wrote:
> The ext4_generic_delete_entry function defines the handle_t type
> variable, handle, as a parameter, but it is not used.
> 
> Signed-off-by: Kyoungho Koo <rnrudgh@gmail.com>

LGTM, feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
