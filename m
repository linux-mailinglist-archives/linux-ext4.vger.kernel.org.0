Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893DC2C4DE2
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Nov 2020 04:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbgKZDyA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Nov 2020 22:54:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730187AbgKZDx7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 25 Nov 2020 22:53:59 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQ3p2eN106232;
        Wed, 25 Nov 2020 22:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kqINen3i/bNXMyyBdnQBchA7tQeXPs2uRmFNT/lCS/0=;
 b=h2nirmbZJC9bsVDpHrIhNUtRmjuG3Nz+3H2XzW2n9kOD6TOIEm3TKM9y0mqAbFjfqOCp
 sW0b2oEh6h2QwWVdPgERyyCrn17fmVpgr/FZZuWuGjUp6Od8cWf/rezRZwHAujlmvHbB
 aurKF/0us+1bQuFsN9k4m0oTv2VJ6f8jl48AXGy20Z1ZmD4LMKACrpAUhwuoFlDet1Xj
 cVAd7U2fWad/mLlG9A2QREsZvcrxyLJsJf3tN4vWja4jdrzQzv3QcgMjeOwARzM4FyZz
 c55pUP81UDn/kOIX0AH/wTAZBJqNob3azV4dPVAhkUYg8P2BvqX6SzTrvBWjJZvlhVBV 0w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3524tqg1h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 22:53:57 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQ3rZHj003209;
        Thu, 26 Nov 2020 03:53:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 34yy8r2ct7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 03:53:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQ3pMNA8061690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 03:51:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3DFD42045;
        Thu, 26 Nov 2020 03:51:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 225F142041;
        Thu, 26 Nov 2020 03:51:21 +0000 (GMT)
Received: from [9.199.32.61] (unknown [9.199.32.61])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Nov 2020 03:51:20 +0000 (GMT)
Subject: Re: [PATCH 0/3] fstests: Fix tests which checks for swapfile support
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, anju@linux.vnet.ibm.com,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <cover.1604000570.git.riteshh@linux.ibm.com>
 <20201101160357.GE3853@desktop>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <c2f91a8e-b831-52c5-7e5e-79dcc7175cd3@linux.ibm.com>
Date:   Thu, 26 Nov 2020 09:21:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201101160357.GE3853@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_14:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260016
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 11/1/20 9:33 PM, Eryu Guan wrote:
> On Fri, Oct 30, 2020 at 01:22:50AM +0530, Ritesh Harjani wrote:
>> For more details, pls refer commit msg of each patch.
>>
>> Patch-1: modifies _require_scratch_swapfile() to check swapon only for btrfs
> 
> I don't think it's a good idea, if a new fs without swapfile support is
> tested by fstests, test would get false failure, where it should
> _notrun. And making a generic requirement check to fs-specific doesn't
> seem quite right either.
> 
>> Patch-2: adds a swapfile test for fallocate files for ext4, xfs (assuming
>> both FS supports and thus should pass).
> 
> As Brian mentioned in his review, we're in the process to convert all
> shared tests to generic or fs-specific tests (very slow though), that
> said we don't want new shared tests.
> 
> I think we could whitelist fs types in _require_scratch_swapfile() and
> don't _notrun for such filesystems, something like what we did in
> _fstyp_has_non_default_seek_data_hole(), so that we won't miss silent
> regressions on sucn filesystems, and we'll do sanity check as well on
> other filesystems.

Nice idea. Let me check that part.

> 
>> Patch-3: added to support tests to run when multiple config section present
>> in local.config file.
> 
> I have a patch[1] that should fix the issue 3 years ago, but it never
> got reviewed, would you please check and see if it fixed the bug for you?
> 
> [1] https://patchwork.kernel.org/project/fstests/patch/20171117070022.14002-1-eguan@redhat.com/

Sure, will test it and get back.

Sorry about the delay from my end on this patch series. I got pulled
into something else. Let me work on your suggestions.


-ritesh
