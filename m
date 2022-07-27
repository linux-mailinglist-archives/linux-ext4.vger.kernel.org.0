Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5C583274
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiG0Sxx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 14:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbiG0Sxj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 14:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA0F5564C6
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658944272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cFBj7bYM41fbdLBT9pSUbRsCO93VFlM0clQRLWukkKs=;
        b=ND84XhqkrcaJUCaQvficJhIN1nwAJlNPwBNUDj4shjXyeFEdHTop/Eh0ahMg4BYpz6Zikn
        FKGO1FoGuzLdN9OBpimdeYAghKiZaGUhnGCh91ZlPDm7BjsPLBrXx7VOj9Rmql99U0NqZF
        3yvdjrpFNxkWmwzO/5r1kkO+jCM5CRU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-hIeJ3yulP1Km3lPlos-Vgg-1; Wed, 27 Jul 2022 13:51:09 -0400
X-MC-Unique: hIeJ3yulP1Km3lPlos-Vgg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A18A811E80;
        Wed, 27 Jul 2022 17:51:08 +0000 (UTC)
Received: from fedora (unknown [10.40.192.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4987E492CA2;
        Wed, 27 Jul 2022 17:51:07 +0000 (UTC)
Date:   Wed, 27 Jul 2022 19:51:04 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: try to flush inline data before calling BUG in
 writepages
Message-ID: <20220727175104.cnth7s452thpuosj@fedora>
References: <983bb802-d883-18d4-7945-dbfa209c1cc8@linaro.org>
 <20220726224428.407887-1-tadeusz.struk@linaro.org>
 <20220727172517.bv2bflydy2urqttv@fedora>
 <29a17172-c8c6-0e69-6e38-e482500d2ae3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a17172-c8c6-0e69-6e38-e482500d2ae3@linaro.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 27, 2022 at 10:40:25AM -0700, Tadeusz Struk wrote:
> Hi Lukas,
> On 7/27/22 10:25, Lukas Czerner wrote:
> > I don't think this is the right fix. We're in ext4_writepages, so at
> > this point I don't think an inode should have any actual inline data in
> > it. If it does it's a bug and the question is how did this get here?
> > 
> > The inode is likely corrupted and it should have been noticed earliler
> > and it should never get here.
> 
> Yes, that was just an attempt fix something that I'm not quite familiar
> with.
> 
> Jan sent already a patch for that fixes it:
> https://lore.kernel.org/all/20220727155753.13969-1-jack@suse.cz/
> 
> -- 
> Thanks,
> Tadeusz
> 

Yeah, I just noticed sorry about that. I was missing the email context
for some reason.

Thanks!
-Lukas

