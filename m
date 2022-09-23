Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681025E7294
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 05:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiIWDyi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Sep 2022 23:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiIWDye (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Sep 2022 23:54:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D1039E
        for <linux-ext4@vger.kernel.org>; Thu, 22 Sep 2022 20:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6574DB815BA
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 03:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0F2C433C1;
        Fri, 23 Sep 2022 03:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663905267;
        bh=0b8qZx/Dn5ZEbcgLdRW7xn+o1HAyAGmZiNloh7DqwqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSnAek8OAiM5A6ppds2zC3rzPfYrvfXDxt8HDN8HvJ0KprDgfbNMj0YhjUWhDAXAq
         j0bdKU5dBwuF7YvCeSc8X8j0SDY6i4K++NL3GvSC9DGmGVE3uEcVnU5YInusoxRzzq
         ViX4UCXsATrqpSJbKSmhguzzJdxDYxvAUr0MONfM56E6tywbxRlL4Azz7pchX/zp5E
         wyO65zg8/BzW9FYeYyIsNRIIirUJGuid+cZ5xIYgtaEc3JvS8e519yl0dXwAxKwhw6
         mNAaOFsfiVfYxmW1bKeSFUMU0QYcihQEsA/zdSTjHRlWr4cP/ogHq3yip9TQB0BKTd
         lr5k1pPOYE7YA==
Date:   Thu, 22 Sep 2022 20:54:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v9 0/8] Clean up the case-insensitive lookup path
Message-ID: <Yy0t8WYhM+Dv3gX1@sol.localdomain>
References: <20220913234150.513075-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913234150.513075-1-krisman@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 13, 2022 at 07:41:42PM -0400, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> I'm resubmitting this as v9 since I think it has fallen through the
> cracks :).  It is a collection of trivial fixes for casefold support on
> ext4/f2fs. More details below.
> 
> It has been sitting on the list for a while and most of it is r-b
> already. I'm keeping the tags for this submission, since there is no
> modifications from previous submissions, apart from a minor conflict
> resolution when merging to linus/master.

Who are you expecting to apply this?

- Eric
