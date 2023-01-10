Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E4664071
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 13:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjAJM2K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Jan 2023 07:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjAJM1o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Jan 2023 07:27:44 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A312E13DCD
        for <linux-ext4@vger.kernel.org>; Tue, 10 Jan 2023 04:27:40 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e21so11617214ybb.3
        for <linux-ext4@vger.kernel.org>; Tue, 10 Jan 2023 04:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6KndhW8ZthnZXH5GZJH/lEnO//E0T9z85lpDRJv/Coo=;
        b=fLHC6l/L0Ijx5D2CAJDRuaGTh0+lAqH7wRXf4FXEos/1kCMAzIGNE/a19cTVHPstyj
         JwaTeSROjJgdKlGX2jhdbFh9OyFkzqux7VGs0+lrSZRTtt+esc/w3XrW1M+qkRBOzrNd
         2+HGDXTDKGfbMGyWkagwgv+cThJ+qjOtFr9rhUtHn7QO3oehJwbga1TlShhaSinIURvU
         54pzeCiKxGHjU4wHJ1X9db9bwm7ajet6de0BfVL4IT7QfNxXO2bScK09DianQE/OI7tU
         jt+NXznD2zJ0+5lt87pz53ZPLKBDIvsa2HqYHFm4kDDKjA7Qdg+pqmsS6UU0Sqqna8hx
         /OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KndhW8ZthnZXH5GZJH/lEnO//E0T9z85lpDRJv/Coo=;
        b=OH7u+q2hjgcrHVOEPU2GWLwUY5cV7LeCMIQjNbCN0Eazi+uV3IZ305d9S+bViItiuF
         Cz3R5JUxLIObCCT02UtMx+1G9vpy1GJI28EJ2G2w3/zxHriZIgC52kXKc+8x9tqGFYQ+
         VOYIzw346LClg99FjRwZTOpq+Bb1oyYGrOYr3p35pAPAH6SWDRZEbQ+LQShdnLb2d9Us
         VFZnm1zosGyfKTIOoH+jnlYdkgbAXc5TvS50V6JYde+2sMNDlO9nS/pgK2TKOh/fOk/p
         egQ8danrYmPzOjEztKTlL+qKvZUJ8jMcQRu6Qm80geE6eJR00TGRyKsII6f1QtKPIpw9
         Dveg==
X-Gm-Message-State: AFqh2kpduVhJ0z1Ez9FkJvN8v9FbwzftzftPbXaiiw6S95RD+t3Dap/s
        ync58n12e6bf/BzU/0F0NHgIXcsGg2wm6YZS8NNJ6w==
X-Google-Smtp-Source: AMrXdXuKs2wl/bseH+adSS22ymofeLisqiz/F7ZTp9k5notKnLu5IuY4AXMn8tcdHRycayafMh+GPeKHWlUwXyTIcIU=
X-Received: by 2002:a25:bbc1:0:b0:6fd:ef90:2ae5 with SMTP id
 c1-20020a25bbc1000000b006fdef902ae5mr5331591ybk.376.1673353659656; Tue, 10
 Jan 2023 04:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20221121112134.407362-1-glider@google.com> <20221121112134.407362-2-glider@google.com>
 <20221122145615.GE5824@twin.jikos.cz>
In-Reply-To: <20221122145615.GE5824@twin.jikos.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 10 Jan 2023 13:27:03 +0100
Message-ID: <CAG_fn=Waivo=jEEqp7uMjKXdAvqP3XPtnAQeiRfu6ptwPmkyjw@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs: affs: initialize fsdata in affs_truncate()
To:     dsterba@suse.cz
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 22, 2022 at 3:56 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Nov 21, 2022 at 12:21:31PM +0100, Alexander Potapenko wrote:
> > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > an error passing the latter to aops->write_end().
> >
> > Fix this by unconditionally initializing fsdata.
> >
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> With the fixed Fixes: reference,
>
> Acked-by: David Sterba <dsterba@suse.com>

Hi David,

I've noticed that the ext4 counterpart of this patch is in the
upstream tree already, whereas the affs, f2fs, hfs and hfsplus
versions are not.
Are they picked via a different tree?
