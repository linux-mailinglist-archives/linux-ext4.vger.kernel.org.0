Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3A701246
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 00:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbjELWum (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 18:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjELWul (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 18:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1C54C15
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 15:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FB4965906
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 22:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AE3C433D2;
        Fri, 12 May 2023 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683931839;
        bh=nXYRhFPTfZeYNs3shFM/TPqJk2ZET0Jeuh1G/3FIVDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zkFK6bOv2/fia1w1M7KO2n26AaBxgPCQdKToKDcywbLLvml6RIPfh+zQBKnTSHVx5
         vo+dXOuAF8eTyEoA843TAtTHTCtAEA7C0fyA8bzCevNQ44KbUrCvgqpVTzTVfmb0gc
         iYFpUt136fo/f0mK3kYdDvfmdRXEGRWUX3P+ZFWE=
Date:   Sat, 13 May 2023 07:50:34 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcus Hoffmann <marcus.hoffmann@othermo.de>
Cc:     tytso@mit.edu, famzah@icdsoft.com, jack@suse.cz,
        linux-ext4@vger.kernel.org
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <2023051300-deploy-cable-9087@gregkh>
References: <20230315185711.GB3024297@mit.edu>
 <578c0eb1-5271-b5fe-afa2-e2c1107b8968@othermo.de>
 <2023051249-finalize-sneak-2864@gregkh>
 <114216cf-6dfe-71b3-0ffe-3883296bc144@othermo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114216cf-6dfe-71b3-0ffe-3883296bc144@othermo.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 12, 2023 at 04:24:30PM +0200, Marcus Hoffmann wrote:
> On 12.05.23 14:19, Greg KH wrote:
> > On Thu, May 11, 2023 at 11:21:27AM +0200, Marcus Hoffmann wrote:
> > > Hi,
> > > 
> > > > On Wed, Mar 15, 2023 at 18:57, Theodore Ts'o wrote:
> > > > 
> > > > Yeah, sorry, I didn't see it since it was in an attachment as opposed
> > > > to with an explicit [PATCH] subject line.
> > > > 
> > > > And at this point, the data=journal writeback patches have landed in
> > > > the ext4/dev tree, and while we could try to see if we could land this
> > > > before the next merge window, I'm worried about merge or semantic
> > > > conflicts of having both patches in a tree at one time.
> > > > 
> > > > I guess we could send it to Linus, let it get backported into stable,
> > > > and then revert it during the merge window, ahead of applying the
> > > > data=journal cleanup patch series.  But that seems a bit ugly.  Or we
> > > > could ask for an exception from the stable kernel folks, after I do a
> > > > full set of xfstests runs on it.  (Of course, I don't think anyone has
> > > > been able to create a reliable reproducer, so all we can do is to test
> > > > for regression failures.)
> > > > 
> > > > Jan, Greg, what do you think?
> > > 
> > > We've noticed this appearing for us as well now (on 5.15 with
> > > data=journaled) and I wanted to ask what the status here is. Did any fix
> > > here make it into a stable kernel yet? If not, I suppose I can still
> > > apply the patch posted above as a quick-fix until this (or another
> > > solution) makes it into the stable tree?
> > 
> > Any reason you can't just move to 6.1.y instead?  What prevents that?
> > 
> 
> We will move to 6.1.y soon-ish (we are downstream from the rpi kernel tree)
> Is this problem fixed there though? I couldn't really find anything
> related to that in the tree?

Test it and see!

And if you are downstream from the RPI kernel tree, my sympathies,
that's a tough place to be given the speed of it updating (i.e. not at
all...)

good luck!

greg k-h
