Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52DC148FD
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2019 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEFLd4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 May 2019 07:33:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbfEFLd4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 May 2019 07:33:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46BXHGf167293
        for <linux-ext4@vger.kernel.org>; Mon, 6 May 2019 07:33:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sahndnuh0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 06 May 2019 07:33:55 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <chandan@linux.ibm.com>;
        Mon, 6 May 2019 12:33:53 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 12:33:49 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46BXmdi54722814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 11:33:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22630AE058;
        Mon,  6 May 2019 11:33:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A36AE045;
        Mon,  6 May 2019 11:33:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.70.42])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 11:33:46 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/13] ext4: encrypt only up to last block in ext4_bio_write_page()
Date:   Mon, 06 May 2019 14:42:14 +0530
Organization: IBM
In-Reply-To: <20190501224515.43059-14-ebiggers@kernel.org>
References: <20190501224515.43059-1-ebiggers@kernel.org> <20190501224515.43059-14-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19050611-4275-0000-0000-00000331DF5D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050611-4276-0000-0000-00003841461E
Message-Id: <5247310.83GBoLVoWW@dhcp-9-109-212-164>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=780 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060102
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thursday, May 2, 2019 4:15:15 AM IST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As an optimization, don't encrypt blocks fully beyond i_size, since
> those definitely won't need to be written out.  Also add a comment.
> 
> This is in preparation for allowing encryption on ext4 filesystems with
> blocksize != PAGE_SIZE.
> 
> This is based on work by Chandan Rajendra.
>

Looks good to me,

Reviewed-by: Chandan Rajendra <chandan@linux.ibm.com>

-- 
chandan



