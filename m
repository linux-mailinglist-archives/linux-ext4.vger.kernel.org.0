Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CDF25305A
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Aug 2020 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgHZNui (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Aug 2020 09:50:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730535AbgHZNu2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Aug 2020 09:50:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QDZxDQ153610;
        Wed, 26 Aug 2020 09:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=/dD/Soc+DSgJPyPCnZCIYdVx/XZSfPozToFkVI4/ewQ=;
 b=UUMHOum679d30wgqY7jaIr3IPjSRKkAN8unNTGI+wxkyOxUHe+Lqu39EHkksbFaHd3QV
 to3/Sv5XqrfV8zxL9ACrxf6NBSw2jsuU7wx00/JlWXTWOAvm2jWb/54Y0Pj2AG6LzEkx
 h1LpVsAdBNNVoSocr2PWf1qxzCvXEj+8hCyfhZo5DbaRJ/Ib2yK8KIgnxW4bydIWVsZb
 C7ZeubHZr1uOwtHwjLxeqRB+7m449MYGtgdobCpSFN6MKrytCCQh/G1dPtAiAokX0ZqW
 tw3I79T330rLqxkpnCU1CnkRvJdZu/3tcFqX8c6k0q2tFhaw/tgcctdwo2zxjl+v2zBh qg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 335rmv0s67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 09:50:20 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QDb1rJ017837;
        Wed, 26 Aug 2020 13:50:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 332uk6cmm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 13:50:18 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QDoGsY62390604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 13:50:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 142404C04A;
        Wed, 26 Aug 2020 13:50:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 443BB4C04E;
        Wed, 26 Aug 2020 13:50:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.157])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 13:50:15 +0000 (GMT)
Subject: Re: [PATCH] ext4: Remove unused argument from ext4_(inc|dec)_count
To:     Nikolay Borisov <nborisov@suse.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
References: <20200826133116.11592-1-nborisov@suse.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 26 Aug 2020 19:20:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200826133116.11592-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200826135015.443BB4C04E@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_08:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=819
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260103
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/26/20 7:01 PM, Nikolay Borisov wrote:
> The 'handle' argument is not used for anything so simply remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Nice catch. Looks good to me, feel free to add.
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
