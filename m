Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29C52DE3C
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 22:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiESUVD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 16:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244675AbiESUU7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 16:20:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FF4AE46
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 13:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51F6961C63
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 20:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6B5C34100;
        Thu, 19 May 2022 20:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652991656;
        bh=3neDrjbhF/v/T8oE/KKYbgKDEEyXfJi6xod+XBBWABY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLekZtrCpwOLi2xPkq359pjCu+X0238sgCYEYWRoQT8r1MnsrNst2Cd22UP35QjCs
         YuM73pwQQnnuQSG0YscHSQ9/gM6f/e8MWaymRjHDT2mCUUQjSo4/gx+sZx2SjnHM16
         EgWYeA9L1/2v4rIZBrdVj9sABN5paTLRPUtua64+1r/Tno+XJ7rc6DoAMvPrapivr9
         VhvwG4Mh7EbTFwwJbhiyqqYy0Y8+V09A3Yz1IZSksocM+g9DbQvVFwHh/tdrlaxajs
         dRiIPEg+ifX1tzzk0dHWOsXp/1kQesydrpxJvzwLBGkxVStW8ToFxu4fFmWUBszU/G
         do5jUTgObEroQ==
Date:   Thu, 19 May 2022 13:20:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v6 4/8] ext4: Reuse generic_ci_match for ci comparisons
Message-ID: <YoampjUJ9Qe060AH@sol.localdomain>
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-5-krisman@collabora.com>
 <YoW8yx9Fw9Rwiaja@sol.localdomain>
 <87h75lnvv9.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h75lnvv9.fsf@collabora.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 19, 2022 at 03:52:10PM -0400, Gabriel Krisman Bertazi wrote:
> > It's hard to reason about, though.  f2fs does things in a much cleaner way, as
> > I've mentioned before, since it decides which type of match it wants at the
> > beginning, when initializing struct f2fs_filename.
> 
> Yes, this is quite confusing. Are these implementation documented
> anywhere?
> 

Not very well.  The f2fs implementation has some comments, though.  E.g. see
struct f2fs_filename and f2fs_setup_filename().

- Eric
