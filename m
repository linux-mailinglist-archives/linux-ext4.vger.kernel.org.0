Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462FC240731
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHJOGV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Aug 2020 10:06:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727028AbgHJOGU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 Aug 2020 10:06:20 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07AE2CWx118516;
        Mon, 10 Aug 2020 10:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=cGyomKEAmw2m1EZIHGC0ZQNOLNl4kskrn5JxSv/w0ro=;
 b=ioJX7GtnhRQ06f2A9OeA7f6ubv5XL7Rzen73O2RoECMWzIYkEGX4SKJJrDN/IpB4Z+aJ
 s5s/of6i1SsfrBANf7q3bgidE515oBjSdzCtta5uEmkT/chFF96jNGHlYm+ieb7163Uh
 yyaa/3n95yv0TP+TobJZyrhk/XoyTpjU1GKNRPyW6aKNNg/1oMq7QcmEPj7Ovhup8mIP
 B3aehgxgM9TAiaNyC5CQ53od7NlhvLgGCVP6YCCtJ/cdFEmGVkqQ0Xa3nD6oC9VQFE5s
 J+WKjXCgrEoFNHXQNkKmVeQUwuAtKVhUtx5yKH8YSietkdd0209LI4yIAANBpjyaQY3X zA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32sravntea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 10:06:12 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07AE6ARU003648;
        Mon, 10 Aug 2020 14:06:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 32skp81edx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 14:06:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07AE68PR23134718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 14:06:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CCE6A4053;
        Mon, 10 Aug 2020 14:06:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34423A4059;
        Mon, 10 Aug 2020 14:06:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Aug 2020 14:06:07 +0000 (GMT)
Subject: Re: [PATCH] mballoc: Replace seq_printf with seq_puts
To:     Xu Wang <vulab@iscas.ac.cn>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200810022158.9167-1-vulab@iscas.ac.cn>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 10 Aug 2020 19:36:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200810022158.9167-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200810140607.34423A4059@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_09:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=18 adultscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=886 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100101
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/10/20 7:51 AM, Xu Wang wrote:
> seq_puts is a lot cheaper than seq_printf, so use that to print
> literal strings.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Looks good to me.
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
