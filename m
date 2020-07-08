Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921CA2184D7
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgGHKWg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 06:22:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgGHKWg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jul 2020 06:22:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068A5ses174734;
        Wed, 8 Jul 2020 06:22:25 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3253uunb0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 06:22:24 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068AEQ1o010160;
        Wed, 8 Jul 2020 10:22:22 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 322hd84hkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 10:22:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068AKmmx56295692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 10:20:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C525AA4062;
        Wed,  8 Jul 2020 10:22:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0399EA405C;
        Wed,  8 Jul 2020 10:22:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.222.188])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 10:22:08 +0000 (GMT)
Subject: Re: [PATCH v2] ext4: lost matching-pair of trace in ext4_unlink
To:     Yi Zhuang <zhuangyi1@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
References: <20200629122621.129953-1-zhuangyi1@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 8 Jul 2020 15:52:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629122621.129953-1-zhuangyi1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200708102209.0399EA405C@b06wcsmtp001.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_07:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 cotscore=-2147483648 malwarescore=0
 suspectscore=0 mlxlogscore=855 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080073
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 6/29/20 5:56 PM, Yi Zhuang wrote:
> If dquot_initialize() return non-zero and trace of ext4_unlink_enter/exit
> enabled then the matching-pair of trace_exit will lost in log.
> 
> v2:
> Change the new label to be "out_trace:", which makes it more clear that
> it is undoing the "trace" part of the code. At the same time, fix other
> similar problems in this function:
> 
> 	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
> 	if (IS_ERR(bh))
> 		return PTR_ERR(bh);
> 	if (!bh)
> 		goto end_unlink;
> 
> According to Andreas' suggestion, split up the "end_unlink:" label becomes
> two separate labels, and then remove the "if (handle)" check, and then
> use out_bh: before the handle is started.
> 
> Signed-off-by: Yi Zhuang <zhuangyi1@huawei.com>

Nice cleanup. Feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
