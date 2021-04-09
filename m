Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E917435942B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 06:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhDIEuq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 00:50:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhDIEuq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 00:50:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1394nwYs086886;
        Fri, 9 Apr 2021 00:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=YcRvpMu/9vERkyRAGFK3jI309SvzNVji2DBgrA2h7RA=;
 b=JoOw46VoQutFl0S5e/MVNNz/omVBJQ2QxpXxBJBXqdRYsqcRudUUekvu4eN7BTGrEh52
 QlIfkCFNZtKmJGmpRXGbioMosqzg8XdDNM+lbZNsxA2eGCximBmcAVczWw51cYQq2SJi
 9H4WchedNbV9JQ8Dj64pU3OIttFEyvx5KDWqvaSOnXvFi2gIL9cbXrFelJ3+cNU9Foij
 TiTvmq523IdUNudrNWNVWb0zvCgtyWIKvMLTjpL7DVocVpeod4rTGXeDxygEB6DqPZ9Z
 MzUdMYTK9VCzkJz9edqxiOIMGumCAAxz1peSo8Nu7nrPIDMfE7myMCT4bN9lBOmh+4Py 2Q== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpw1w41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 00:50:29 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1394m5nZ000471;
        Fri, 9 Apr 2021 04:50:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 37rvbsh5fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 04:50:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1394oOuM36504056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 04:50:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 219F552052;
        Fri,  9 Apr 2021 04:50:24 +0000 (GMT)
Received: from localhost (unknown [9.85.70.102])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BDFFD52057;
        Fri,  9 Apr 2021 04:50:23 +0000 (GMT)
Date:   Fri, 9 Apr 2021 10:20:23 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Jack Qiu <jack.qiu@huawei.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH -next] ext4: fix trailing whitespace
Message-ID: <20210409045023.bcxnxfbnwyshoewv@riteshh-domain>
References: <20210409042035.15516-1-jack.qiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409042035.15516-1-jack.qiu@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6vSZSqxYX-WMVv8yKlyT5lH5BNWGh3bN
X-Proofpoint-GUID: 6vSZSqxYX-WMVv8yKlyT5lH5BNWGh3bN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=684 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090032
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/04/09 12:20PM, Jack Qiu wrote:
> Made suggested modifications from checkpatch in reference to ERROR:
>  trailing whitespace

Also happens to be useful to folks who have auto remove of any whitespace
at end of line on file save in their editor setup ;)

" for vim
autocmd BufWritePre * %s/\s\+$//e

So, patch looks good to me.
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

>
> Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
> ---
>  fs/ext4/balloc.c  | 2 +-
>  fs/ext4/mballoc.c | 2 +-
>  fs/ext4/namei.c   | 6 +++---
>  fs/ext4/super.c   | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>

-ritesh
