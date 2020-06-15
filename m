Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22DB1F9551
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jun 2020 13:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgFOL2L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Jun 2020 07:28:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4868 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728510AbgFOL2J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 15 Jun 2020 07:28:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FA3pFj068854;
        Mon, 15 Jun 2020 07:27:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31n0j7nvds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 07:27:55 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FA4PE5071077;
        Mon, 15 Jun 2020 07:27:54 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31n0j7nvd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 07:27:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FBPYpe016585;
        Mon, 15 Jun 2020 11:27:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31mpe7uech-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 11:27:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05FBRoJ564291194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 11:27:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9A645204E;
        Mon, 15 Jun 2020 11:27:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.25])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 104AF52054;
        Mon, 15 Jun 2020 11:27:48 +0000 (GMT)
Subject: Re: 5.8-rc1: new warnings in ext4_mb_new_blocks?
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
References: <20200615073712.GA4164@duo.ucw.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 15 Jun 2020 16:57:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615073712.GA4164@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200615112749.104AF52054@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_02:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 cotscore=-2147483648
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150082
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 6/15/20 1:07 PM, Pavel Machek wrote:
> Hi!
> 
> Booting 5.8-rc1 on x220, I get scary warnings:
> 
> [    7.089941] EXT4-fs (sdb2): mounted filesystem with ordered data mode. Opts: errors=remount-ro
> [    7.343231] BUG: using smp_processor_id() in preemptible [00000000] code: systemd-tmpfile/2788
> [    7.344052] caller is debug_smp_processor_id+0x17/0x20
> [    7.344897] CPU: 3 PID: 2788 Comm: systemd-tmpfile Not tainted 5.8.0-rc1+ #116
> [    7.345745] Hardware name: LENOVO 42872WU/42872WU, BIOS 8DET74WW (1.44 ) 03/13/2018
> [    7.346561] Call Trace:
> [    7.347355]  dump_stack+0x60/0x7a
> [    7.348170]  check_preemption_disabled+0xb1/0xc0
> [    7.348951]  debug_smp_processor_id+0x17/0x20
> [    7.349728]  ext4_mb_new_blocks+0x1f2/0x13e0
> 
> and they continue after boot.
> 

Below should fix this. I guess it couldn't make it to rc1.

https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=ext4-for-linus-5.8-rc1-2&id=811985365378df01386c3cfb7ff716e74ca376d5

-ritesh
