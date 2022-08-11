Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFFF58F659
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Aug 2022 05:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiHKDSj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Aug 2022 23:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiHKDSh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Aug 2022 23:18:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BF97CB5C
        for <linux-ext4@vger.kernel.org>; Wed, 10 Aug 2022 20:18:34 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27B3INWn018101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 23:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660187905; bh=cfzkZkjWh/iJBOdhJ25KomYkKGtIXUQjC4hmQ+tsZqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YUnr5ztXgrPprVW069WHqC/XBAmrPnW+cpAD4uyJsY45OZmpFbdVGfj39rlKGBBj/
         4vZEE3mg2tHp6QonZLtUlCuFcP0x6r5+QpdJmp1vAhPr6/Z1Q8a6kTLuHAhKUCj1gJ
         I4dMEbezhBwjG34GVlQO/FhfcQTOGwAwzhXNEVR8yNhJ41Vr1/YHpEXLliTmN+3kOL
         e14IioiSSqhCHHwljbJKW6cJoZ1hRsr4/l7WVaZxI0lhrwxDRkeA6cyqeVYdhOkwNK
         eHdNyGIunOdPBzpV466oUcCQKDFB4HYiOePGYDJqht1w+IfK0ECLG3aqu4frJB97Da
         4o3CnatDdYIGg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 8FCEE8C2E04; Wed, 10 Aug 2022 23:18:23 -0400 (EDT)
Date:   Wed, 10 Aug 2022 23:18:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Daniel Ng <danielng@google.com>
Subject: Re: [PATCH] e2fsprogs: fix device name parsing to resolve names
 containing '='
Message-ID: <YvR0/wmZgf1HwidK@mit.edu>
References: <20220805094703.155967-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805094703.155967-1-lczerner@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Lukas,

Could you move get_devname() into its own file in lib/support?  e.g.,
create a devname.c and devname.h.

The reason for this is that plausible.c tries to call libmagic via
dlopen() so we don't need to drag libmagic into the minimal package
set for distros.  But that means that any executiables that try to use
devname() will drag in lib/support/pausible.c, which means if you
don't change the makefiles to link in -ldl, static linking will fail:

					- Ted
