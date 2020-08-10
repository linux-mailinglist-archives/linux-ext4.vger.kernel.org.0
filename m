Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5412406E7
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHJNoY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Aug 2020 09:44:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726569AbgHJNoX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 Aug 2020 09:44:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07ADXXZj028960;
        Mon, 10 Aug 2020 09:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=XXXqoePBOa4qDr3rIBArYqgR5RCbpncK4XHJVflsofk=;
 b=ik2Y2ILYxYkZ2+P9ojK6tL/ZE2QR5Xy+hvTltnSB7TI1GF1rxzyXP42v9NjoijNdc3ZJ
 QUeP+5wal9dc6eldObVeq+97UoWm+Sts0AiVnTqgGkMWqhNuvcpSoGVM+DgFRJpOwdzi
 kVOE23yDLhUBlfJNhSD7YKMFJyqhUDhypkSohItvig6aitTjJiRVb1rz4ybHq5nou3P9
 1GV3VxzJrW891Am62fphFA3/uY27ZG+Bj+PFEkLRWh4uK2m0nqa3Dfm3zAnrA6Cysf1C
 K0cHdhBBZFjkde1Ju9lUSPO9O/1BKgV7O7vMcM92ZIMWY7KsxLpXeM3Zf8I8KjIANPb+ vw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32u4g1n5uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 09:44:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07ADa4va010168;
        Mon, 10 Aug 2020 13:44:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 32skp82a6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 13:44:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07ADi8EY13959538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 13:44:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD120AE058;
        Mon, 10 Aug 2020 13:44:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B7E2AE04D;
        Mon, 10 Aug 2020 13:44:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Aug 2020 13:44:07 +0000 (GMT)
Subject: Re: [PATCH] ext4: change to use fallthrough macro instead of
 fallthrough comments
To:     Shijie Luo <luoshijie1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz
References: <20200810114435.24182-1-luoshijie1@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 10 Aug 2020 19:14:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200810114435.24182-1-luoshijie1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <20200810134408.0B7E2AE04D@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_09:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=552 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100101
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/10/20 5:14 PM, Shijie Luo wrote:
> Change to use fallthrough macro in switch case.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>

pseudo-keyword macro “fallthrough” should be used as per latest
documentation.
https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through


LGTM, feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
