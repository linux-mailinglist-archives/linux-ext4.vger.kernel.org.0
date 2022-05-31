Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7579753957A
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 19:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346559AbiEaRb4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 May 2022 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344711AbiEaRbz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 May 2022 13:31:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B15D27FEF;
        Tue, 31 May 2022 10:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2552F6102F;
        Tue, 31 May 2022 17:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8A9C385A9;
        Tue, 31 May 2022 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654018313;
        bh=cM0mLgtDwe39r85Qpbwx1gsGZl9Em45suJNmKfe2840=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OKOg1WE09YZpMfWsIy3ozjQL4j7YRHDfSWT7tpHSI4MbkjXTm/nxPhAOzaTq9nu6L
         5oThGX/yQh5E/+oczf87CwQhJN1ZPq0rn6/MKsFTFqhWxZK+SEJH5R4IF5DyWaK4+e
         5hdkzB4zjrPJroW1rabz6XKjJaQAMgDQaW1OYYD4=
Date:   Tue, 31 May 2022 10:31:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     <jgg@nvidia.com>, <david@redhat.com>, <Felix.Kuehling@amd.com>,
        <linux-mm@kvack.org>, <rcampbell@nvidia.com>,
        <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <hch@lst.de>, <jglisse@redhat.com>, <apopple@nvidia.com>,
        <willy@infradead.org>
Subject: Re: [PATCH v4 07/13] lib: test_hmm add ioctl to get zone device
 type
Message-Id: <20220531103152.6b9214cc39a87020d7d7927b@linux-foundation.org>
In-Reply-To: <20220531155629.20057-8-alex.sierra@amd.com>
References: <20220531155629.20057-1-alex.sierra@amd.com>
        <20220531155629.20057-8-alex.sierra@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 31 May 2022 10:56:23 -0500 Alex Sierra <alex.sierra@amd.com> wrote:

> new ioctl cmd added to query zone device type. This will be
> used once the test_hmm adds zone device coherent type.
> 
> @@ -1026,6 +1027,15 @@ static int dmirror_snapshot(struct dmirror *dmirror,
>  	return ret;
>  }
>  
> +static int dmirror_get_device_type(struct dmirror *dmirror,
> +			    struct hmm_dmirror_cmd *cmd)
> +{
> +	mutex_lock(&dmirror->mutex);
> +	cmd->zone_device_type = dmirror->mdevice->zone_device_type;
> +	mutex_unlock(&dmirror->mutex);

What does the locking here do?

Presumably cmd->zone_device_type can become out of date the instant the
mutex is released, so what was the point in taking the mutex?

And does it make sense to return potentially out-of-date info to
userspace?  Perhaps this interface simply shouldn't exist?
