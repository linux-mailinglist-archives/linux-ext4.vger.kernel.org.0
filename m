Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B672444FF
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Aug 2020 08:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgHNGZ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Aug 2020 02:25:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgHNGZ0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 14 Aug 2020 02:25:26 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07E6107Y065151;
        Fri, 14 Aug 2020 02:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=Vjv7GEOXeXesi9mMjVXI6IjkG98N9rXSglUY2Ue8KuE=;
 b=MQeM/g2S66Li3ZunrzCjzQMESy6THTdlkzTczby+bLGSejb42o4H8rfDgtoG95Rq6ljr
 O69w53skRl/qHgTa+GsmZh8Zjrqytxfo2MmO1Ij2uOu1VNsOXH3Yby3NY7Xfbr8xouum
 IUlhEgLI9AxsIdf1BfqwPoTN0yZG7W5Eb95P8Qe/6MoZRRj5y3B/bXeqZ3K/jRQHG9LT
 8P+7oPDUFIICGHGYpqkETBaizi3E47cf0WrKyq13aRXR1q3Cc/YqzBc3y3lzqKTIEr8n
 ZsptuzmYxMlrCR+FCnZXKqrwRa98pwSzKhg52PtsBcVLZWGE3SvfrEnPMVITGBVOsyBp Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w0n1bmk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Aug 2020 02:25:23 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07E6Lj5C123407;
        Fri, 14 Aug 2020 02:25:23 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w0n1bmjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Aug 2020 02:25:23 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07E67CN8016636;
        Fri, 14 Aug 2020 06:25:21 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 32skah3vt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Aug 2020 06:25:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07E6PJ5n20644242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Aug 2020 06:25:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26337A404D;
        Fri, 14 Aug 2020 06:25:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67BFBA4053;
        Fri, 14 Aug 2020 06:25:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Aug 2020 06:25:17 +0000 (GMT)
Subject: Re: [PATCH v4 1/2] ext4: reorganize if statement of
 ext4_mb_release_context()
To:     brookxu <brookxu.cn@gmail.com>, adilger.kernel@dilger.ca,
        tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
References: <03e83854-e5b3-ef78-e004-4de4689e84da@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 14 Aug 2020 11:55:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <03e83854-e5b3-ef78-e004-4de4689e84da@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200814062517.67BFBA4053@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-14_02:2020-08-13,2020-08-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 mlxlogscore=750 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008140044
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/7/20 2:14 PM, brookxu wrote:
> Reorganize the if statement of ext4_mb_release_context(), make it
> easier to read.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

LGTM, please feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
