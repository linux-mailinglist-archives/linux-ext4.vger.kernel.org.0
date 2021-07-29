Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A683DA050
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jul 2021 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhG2JfU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jul 2021 05:35:20 -0400
Received: from out0.migadu.com ([94.23.1.103]:12176 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235622AbhG2JfT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Jul 2021 05:35:19 -0400
Subject: Re: [PATCH] ext4: reduce arguments of ext4_fc_add_dentry_tlv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1627551313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wO7+0jkdcPK7zm49zN66/2Fx519T7HQWv/cNrIxpVP0=;
        b=dqDNOfLkpFi501QbjylOhRz5pIe99Lb+oTed1IgMj0a2JV12F8rVUmDqQByxbLtweMnZT7
        eXRkZa2wjLqRfIBwMtsZAGxP1PQ0M6nE5rCmcGurQMy+FlNmQyIjRoHXnJN2dbTv+y9KYZ
        b0VIu8EjFIXxUisO4aDdRg7Defmf6kc=
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20210727080708.3708814-1-guoqing.jiang@linux.dev>
 <CAD+ocbyXcJ4YwEhsV4YO1B9m_K8S-OT1S6aoTp-u4UPYndoc=g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <e7fe0d07-4ff3-82b1-d56b-4307c5668fe5@linux.dev>
Date:   Thu, 29 Jul 2021 17:35:05 +0800
MIME-Version: 1.0
In-Reply-To: <CAD+ocbyXcJ4YwEhsV4YO1B9m_K8S-OT1S6aoTp-u4UPYndoc=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 7/28/21 1:36 AM, harshad shirwadkar wrote:
> Thanks for the cleanup! Looks good.
>
> Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks for your review!

Guoqing
