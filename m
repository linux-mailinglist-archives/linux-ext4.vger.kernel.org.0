Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D710449DB6C
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jan 2022 08:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiA0H1T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jan 2022 02:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiA0H1T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jan 2022 02:27:19 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A79C061714
        for <linux-ext4@vger.kernel.org>; Wed, 26 Jan 2022 23:27:19 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id k31so5969175ybj.4
        for <linux-ext4@vger.kernel.org>; Wed, 26 Jan 2022 23:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zbP40bb0DGAe6e6XbNZJi+0uIULYcVDbvLAFYA13OOA=;
        b=NH36Zp+47JMvvVihqUjgFINwTaoWbTUz7tqKDPIyCJeRgSNsJAaUYfHTQxBON/46Kv
         rh1n/ZJQnwphNwuR2IJP2RtyOSDsqKs2rwddxixaE1ZH3C2z2M4yeQkdrSKA3kefopOO
         ImqZTE0hMcuqsiSp+aL+uP5g5t5F3eQYePYiZFjFfYxVvJdVseEID2IC6qWwnKITIEtq
         YSF9mnHxDBQiIDHijCWjTcVa6sLsijjND03xdNGCZueqS2le5fbfTgYC/wpjKXzujs45
         tUYvpZesrCjsnNKDQoaj5mWK5qww5XqhxS3EaxUIDNlQhxOMqbY3IJ/XzKJMDAGgdZ6/
         QtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zbP40bb0DGAe6e6XbNZJi+0uIULYcVDbvLAFYA13OOA=;
        b=sY7NqaIwrlPu3eviDjIvvP8LTg552sMXiSQ+ItGtlQsIZT00O0inYcHtVxA6nZ4RFj
         AURijQpAeC85FYPlvr7OTp79fCzmGKjmvHicOp4QH/ZcIvjolC9yjYSEVmqMeBiKQrsq
         6rgEm3DwbqlqIM3q/hcZJdIlxO+xFkbu1b+uaMbQ8fbYoL3nUBVR3D+o5/EfCT7LyA5E
         5GrrSWjBON28IHScsQ6Usj4sMcBHMRvQOhkcNYFKaqF3SPKYVQ95dCV07Kul4fb0P4Cc
         kbJ5Ucze9vfRPaj6py0fTivXYvkQST4vOHYfzj6RfPL/vwP+ZsBah/agpyRWGnJWoalv
         ZW4Q==
X-Gm-Message-State: AOAM533PgbJUslln7ziEhK6ukgM6/76AbN3SR6GnLJSyrh+xEPLs5tWc
        Ut9+gnDfrcrCBwbXM5DtahfEgw8hA3YSUaCzKrrLg049GhlKYw==
X-Google-Smtp-Source: ABdhPJxyDyAWYwKWOWrcDgWdoyhd+3VeoEfIqOk+zt5oUfnA85+Plofk9jEB9V4nYLG5eDnTaCYwOij6Fqq9rWj/6Oc=
X-Received: by 2002:a25:df89:: with SMTP id w131mr3731662ybg.692.1643268438171;
 Wed, 26 Jan 2022 23:27:18 -0800 (PST)
MIME-Version: 1.0
References: <d4a67b38-3026-59be-06a8-3a9a5f908eb4@embecosm.com>
In-Reply-To: <d4a67b38-3026-59be-06a8-3a9a5f908eb4@embecosm.com>
From:   Maxim Blinov <maxim.blinov@embecosm.com>
Date:   Thu, 27 Jan 2022 07:27:07 +0000
Message-ID: <CADmoyEhWLSktBi1weWDNfBcDgqkk7PPAFVYYHcbMGruwUp_0EQ@mail.gmail.com>
Subject: Re: Help! How to delete an 8094-byte PATH?
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I forgot to mention in the first email: I'm running Ubuntu 20.04 in a
RISC-V QEMU image, so it's not exactly your standard setup.

I've also made an interesting observation. If I descend to the very
bottom of the directory tree, I can trigger the following behaviour:
```
$ mkdir b
$ ls
a  b
$ rmdir b
rmdir: failed to remove 'b': File name too long
```
(the file 'a' was created from an earlier experiment.)
