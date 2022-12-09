Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42F3647D54
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 06:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLIFgb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Dec 2022 00:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiLIFgX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Dec 2022 00:36:23 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2300F6150B
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 21:36:23 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B95Zssm022122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Dec 2022 00:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670564156; bh=eSbVoCUdJbk6Go9Rw3eCMlciNdfEcHT9KA/Tb9LDJww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NSyyvx2xNQFpKVZrdw4ymjx8XFiNgXzuVGJsZCRT+fl+nPazgezA56RYJL7mYcUeu
         9UFWeLR9GFQ2KRxJE2ATnOeAx72O8F6JrIDrIjxvncxpwZu7SZoun8fHek+ZYXHCd7
         bkLWYTayvhG6BhTXqwUQD9kcETDdAz1olGAYy0fX4pLZoMbkH6xXHmbo79Vo9iy2VZ
         uroLh368rAukPakO4bqTNtUAzaMROb3VcGv8XrxuNFUCQtVcgESJ3Aj+0hSDZbedGs
         LaMPLIv9UpNrwCaKGqLJlE3kHYsJwQ3YzwJYx3kacf4ehNK1IdKZeTrxp2qb2f5qwX
         bjVzEt8n35uZg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D251115C3AE9; Fri,  9 Dec 2022 00:35:54 -0500 (EST)
Date:   Fri, 9 Dec 2022 00:35:54 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 2/4] ext4: allocate extended attribute value in
 vmalloc area
Message-ID: <Y5LJOp9EdyIUsjtI@mit.edu>
References: <20221208023233.1231330-1-yebin@huaweicloud.com>
 <20221208023233.1231330-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208023233.1231330-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 08, 2022 at 10:32:31AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, extended attribute value maximum length is 64K. The memory requested
> here does not need continuous physical addresses, so it is appropriate to
> use kvmalloc to request memory. At the same time, it can also cope with
> the situation that the extended attribute will become longer in the future.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
