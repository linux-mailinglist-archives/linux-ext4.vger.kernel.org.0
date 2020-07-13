Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16321D772
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jul 2020 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgGMNpD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jul 2020 09:45:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728950AbgGMNpC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Jul 2020 09:45:02 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DDWWl5108173;
        Mon, 13 Jul 2020 09:44:54 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792u3jgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 09:44:53 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06DDadtB009169;
        Mon, 13 Jul 2020 13:44:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 327527t8k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 13:44:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06DDinfZ57409608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 13:44:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 469D0A4053;
        Mon, 13 Jul 2020 13:44:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CFA3A4051;
        Mon, 13 Jul 2020 13:44:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.60.200])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jul 2020 13:44:48 +0000 (GMT)
Subject: Re: [PATCH] ext4: catch integer overflow in ext4_cache_extents
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Wolfgang Frisch <wolfgang.frisch@suse.com>
References: <20200713125818.21918-1-jack@suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 13 Jul 2020 19:14:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200713125818.21918-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200713134448.4CFA3A4051@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_11:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130098
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 7/13/20 6:28 PM, Jan Kara wrote:
> From: Wolfgang Frisch <wolfgang.frisch@suse.com>
> 
> When extent tree is corrupted we can hit BUG_ON in
> ext4_es_cache_extent(). Check for this and abort caching instead of
> crashing the machine.

Was it intentionally made corrupted by crafting a corrupted disk image?
Are there more such logic in place which checks for such corruption at 
other places? Maybe a background over the issue which you saw may help.
Also how did it recover out of it?

Do you think it make sense to still emit a WARN_ON() here and then
return which warns that this could possibly a corrupted extent
entry? (maybe WARN_ON_ONCE() or via some ratelimiting if multiple extent 
entries are corrupted for that inode).

-ritesh
