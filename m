Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4212D3D5198
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jul 2021 05:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhGZDCN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Jul 2021 23:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhGZDCM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Jul 2021 23:02:12 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5D0C061757;
        Sun, 25 Jul 2021 20:42:41 -0700 (PDT)
Subject: Re: [PATCH V3 1/5] ext4: remove the 'group' parameter of
 ext4_trim_extent
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1627270960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIKUOM1qFVtj2putWoUkmBP9qdwIlEl4y16S5EkJxhM=;
        b=jRbVPuzYsiHmKdgcx+SmQXSdLTB0AJM0432WkBZuCyyo75MkmDmt3MgObdowgvcQvp/sYq
        aJNxwFVsDCDzDuLVP8LPNvT3lJEy/p/fMosxLoUQFqZW8jj/kcUa4lUXq2dMKMPtNvs5o4
        1X0TiTP8xqu9jNStUpqhCCE829IGTIg=
To:     Wang Jianchao <jianchao.wan9@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-2-jianchao.wan9@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <68e1530d-46c5-7879-0191-b62356759d3a@linux.dev>
Date:   Mon, 26 Jul 2021 11:42:33 +0800
MIME-Version: 1.0
In-Reply-To: <20210724074124.25731-2-jianchao.wan9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 7/24/21 3:41 PM, Wang Jianchao wrote:
> -static int ext4_trim_extent(struct super_block *sb, int start, int count,
> -			     ext4_group_t group, struct ext4_buddy *e4b)
> +static int ext4_trim_extent(struct super_block *sb,
> +		int start, int count, struct ext4_buddy *e4b)

Nit, seems only need to change the second line.

Thanks,
Guoqing
