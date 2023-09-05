Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A4F79248F
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Sep 2023 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjIEP7K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Sep 2023 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354041AbjIEJ1I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Sep 2023 05:27:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B1212E
        for <linux-ext4@vger.kernel.org>; Tue,  5 Sep 2023 02:27:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-402bec56ca6so170375e9.0
        for <linux-ext4@vger.kernel.org>; Tue, 05 Sep 2023 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693906021; x=1694510821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QivlHq495u/KUMjd8H66huPqjXNAmSye3h8RVHL8dfQ=;
        b=kHWjUPh5E9P0PuMc1KvzZrpbBJIlK+fqtQ51r5spaT/X71HFQ1cFrIYmojupmeatNc
         iK9Jf6KueruDB3aavndU6yXWEyu4UokzrV0ad20yU9W+Vjl7OPwUSGH6oaCtW601eiBq
         8pgqVZ4bYHmcU9fGUepyeF+I1+Ia3NddyVr09DtoXzsalyaR3ygWs4rLiLAO/xeOSqRJ
         HQGg+4zYX2hwLIzgjwzq2kE9X/ZBWHMIuGjrtGa3bHwmYTCxnYFV5YwFHFK5OQsxvgTk
         IHTAmTWdYteCZS+OW/u8OBXW/XkP1OnALba/BEfDbpXYFFm1t2CdP5Oc9xUvw/nuSKAj
         +WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693906021; x=1694510821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QivlHq495u/KUMjd8H66huPqjXNAmSye3h8RVHL8dfQ=;
        b=Xhmraf4le1/h7eYxsIx0/ADia7xv7n2aevE4CzwqN+lwkNPXBUYRlII8gYmHt/N5Ro
         6gmuBI46qGer15I8Lnm8hALA+etBpgvkWC8dLHhWWGpdKzz7kSuRtH7zlaKsYdq4G8JK
         OvemwPzitRzr7wO8RGx6amCEH3wzPrF74xm6TJ9aGGU97/GptlkqWSXLbnuVjTE8unIk
         /2rGYJl7HcEvjRHa+HDPunkLRBe6CUgYw1j4oA1dwTgIjBf6G16H29on758Jh1JYKhOG
         Zu4XiUzrjWuPi1yYs9oyyKYmlCkbQgnCs/arjWZ8vK+dYwh5ppdhrQWAQgHuXOjUe9c9
         joMg==
X-Gm-Message-State: AOJu0Yx1HTfmzCnOt2GlRvpp+7meXiBuiAu6oHOC3GKls6Dk82ivqcoF
        +x1df9TSXcQ6ju/ROCE64k7Z4yNmGUeEAflGUwYkJw==
X-Google-Smtp-Source: AGHT+IGENfu5/HhYPIWUo6x3+albtxhQtbOQlDFueHeuAVWyG78SAwIxkvUDeE8EOtxevF3nTDBpl1nNYQYGKf57LhM=
X-Received: by 2002:a05:600c:512a:b0:3fe:e9ea:9653 with SMTP id
 o42-20020a05600c512a00b003fee9ea9653mr263627wms.4.1693906020688; Tue, 05 Sep
 2023 02:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e76944060483798d@google.com> <ZPbcdagjHgbBE6A8@infradead.org>
In-Reply-To: <ZPbcdagjHgbBE6A8@infradead.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 5 Sep 2023 11:26:48 +0200
Message-ID: <CANp29Y65sCETzq3CttPHww40W_tQ2S=0HockV-aSUi9dE8HGow@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] [ext4?] kernel BUG in __block_write_begin_int
To:     Christoph Hellwig <hch@infradead.org>
Cc:     syzbot <syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        yukuai3@huawei.com, zhang_shurong@foxmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 5, 2023 at 9:45=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> syz test: git://git.infradead.org/users/hch/misc.git bdev-iomap-fix

A minor correction:

#syz test: git://git.infradead.org/users/hch/misc.git bdev-iomap-fix
