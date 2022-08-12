Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20E8590C4F
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Aug 2022 09:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiHLHMs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 03:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiHLHMr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 03:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86C592B26A
        for <linux-ext4@vger.kernel.org>; Fri, 12 Aug 2022 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660288365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RxCWTrUzTKGJdfn8jwCYRA0U1IFHnE8cY7upB+72a5c=;
        b=YiT0XJE/mmCpapj7Pln1KdT8uAK2ckPryxn8cy+8wlQtr21Jl4c1bl8vct49/fTQ8UB+o0
        DW/doOQ4+ZTpreg9jCGGGkbohC5ayr4N9K5VRKWNiNEAe1AjUG89XtoWcriiehnvFlkDc3
        5XgbJefkdedeiL5UKwICCUjsGGQLYf0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-UKXpHHQjO76Y0n_vFr1sQw-1; Fri, 12 Aug 2022 03:12:42 -0400
X-MC-Unique: UKXpHHQjO76Y0n_vFr1sQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CE2E294EDFC;
        Fri, 12 Aug 2022 07:12:41 +0000 (UTC)
Received: from fedora (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60C271415124;
        Fri, 12 Aug 2022 07:12:40 +0000 (UTC)
Date:   Fri, 12 Aug 2022 09:12:38 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Daniel Ng <danielng@google.com>
Subject: Re: [PATCH] e2fsprogs: fix device name parsing to resolve names
 containing '='
Message-ID: <20220812071238.d766gj3do7clwhdn@fedora>
References: <20220805094703.155967-1-lczerner@redhat.com>
 <YvR0/wmZgf1HwidK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvR0/wmZgf1HwidK@mit.edu>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 10, 2022 at 11:18:23PM -0400, Theodore Ts'o wrote:
> Hi Lukas,
> 
> Could you move get_devname() into its own file in lib/support?  e.g.,
> create a devname.c and devname.h.
> 
> The reason for this is that plausible.c tries to call libmagic via
> dlopen() so we don't need to drag libmagic into the minimal package
> set for distros.  But that means that any executiables that try to use
> devname() will drag in lib/support/pausible.c, which means if you
> don't change the makefiles to link in -ldl, static linking will fail:
> 
> 					- Ted

Ah, I didn't notice that. I'll move it into a separate file,
devname.[ch] sounds good.

Thanks!
-Lukas

