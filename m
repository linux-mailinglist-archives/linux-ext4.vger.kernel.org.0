Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B14700787
	for <lists+linux-ext4@lfdr.de>; Fri, 12 May 2023 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbjELMTV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjELMTU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 08:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E007DA2
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 05:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6016619E9
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 12:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30388C433EF;
        Fri, 12 May 2023 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683893958;
        bh=tJRI0sNNdg0QHzmjugSwQNy1XmlB4nGCy03RVizfaNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEii5Bjt8Co8rJKdqMU8Jfp57SobkkYPbI1TI0lXetxel2Alrcfd4pdMIFrRTcaRg
         5P042Z8nbp6Bd1BkeSTAh5XLtU3BTzHhKWXpuXZKLlPxclsqUyMFfWnxZyL+xbbaSC
         QVfH6Z8ehSW9WRB9ykBksztmjjmYOlMyt5MAK0Es=
Date:   Fri, 12 May 2023 21:19:11 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcus Hoffmann <marcus.hoffmann@othermo.de>
Cc:     tytso@mit.edu, famzah@icdsoft.com, jack@suse.cz,
        linux-ext4@vger.kernel.org
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <2023051249-finalize-sneak-2864@gregkh>
References: <20230315185711.GB3024297@mit.edu>
 <578c0eb1-5271-b5fe-afa2-e2c1107b8968@othermo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578c0eb1-5271-b5fe-afa2-e2c1107b8968@othermo.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 11, 2023 at 11:21:27AM +0200, Marcus Hoffmann wrote:
> Hi,
> 
> > On Wed, Mar 15, 2023 at 18:57, Theodore Ts'o wrote:
> > 
> > Yeah, sorry, I didn't see it since it was in an attachment as opposed
> > to with an explicit [PATCH] subject line.
> > 
> > And at this point, the data=journal writeback patches have landed in
> > the ext4/dev tree, and while we could try to see if we could land this
> > before the next merge window, I'm worried about merge or semantic
> > conflicts of having both patches in a tree at one time.
> > 
> > I guess we could send it to Linus, let it get backported into stable,
> > and then revert it during the merge window, ahead of applying the
> > data=journal cleanup patch series.  But that seems a bit ugly.  Or we
> > could ask for an exception from the stable kernel folks, after I do a
> > full set of xfstests runs on it.  (Of course, I don't think anyone has
> > been able to create a reliable reproducer, so all we can do is to test
> > for regression failures.)
> > 
> > Jan, Greg, what do you think?
> 
> We've noticed this appearing for us as well now (on 5.15 with
> data=journaled) and I wanted to ask what the status here is. Did any fix
> here make it into a stable kernel yet? If not, I suppose I can still
> apply the patch posted above as a quick-fix until this (or another
> solution) makes it into the stable tree?

Any reason you can't just move to 6.1.y instead?  What prevents that?

thanks,

greg k-h
