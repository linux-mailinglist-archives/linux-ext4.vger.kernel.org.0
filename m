Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B913EAA5C
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2019 06:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfJaFfI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Oct 2019 01:35:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33047 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfJaFfI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Oct 2019 01:35:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id u13so4351000ote.0
        for <linux-ext4@vger.kernel.org>; Wed, 30 Oct 2019 22:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhr8CmMadr7RqtPcqLxf13TLSK+eNsp9nb4CWr3W31o=;
        b=UvRbsqnAFbzZb7VKq8aslazYwCvEdZKfhh6bmsBYZVfdlbifYazZTiidTqn3VuXlxq
         D9yvb5PcB0Ruil5OcesVdMJscLMbcyd+FFZNeFQdGrwQKlpG160bz/ME8Rfjg1bDtk6B
         iJMuJt4W5ni6Shx5oal855Qv3MRiRdtXagIfvW5rnMtU1Vm01WQ0C2NmW5B2WtJebGMY
         01HNAUvL25a0yIll8RU+TzkbCgjwb5BVTkcCaAGm1aMxjH+JMEGFRbJSy7FqFmRO6dfX
         dUfmQSXW4Y717Oh2i2nPIlkzHp06V10HKOfwOvkZ4lMQcKt6WP069K1zReoUc7N2NFwR
         hTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhr8CmMadr7RqtPcqLxf13TLSK+eNsp9nb4CWr3W31o=;
        b=A1jdFGi5RfWZZSSI+vufhTGE4C4lpZmiJwncOGoHxgUMxmIFoWS6UrI8m8jgcP0eCi
         2i6fA5vAMirYdP5tEK4FRXBpOZDl1vYAWal/saxbAVTyXNye1elpusP2QTtNxS7UFDsB
         9zKXTmZCQP1fpunFQ5WB5+XWBjKbe4fEXB67KUXsnARVbEFz33XpXUvzMUpEE6kyhXWE
         8ukwWEeSQnGRQvMemfovJYGbbvRJ3t3YZs2gHCxhvtIBdG3iJz8TmWfJiErSk2Qp0fd3
         SilGr9oJethsBwGCBXOXUYsVWUwbOLODNGbtRRNrLo5yeOoqiAM1Y0AM/kiDvzZKYTjS
         pFPA==
X-Gm-Message-State: APjAAAU4VpQwHSlixApwxNyI5TbSGSvYYER7yrurnmCUk6xg20Dae/N8
        43lYK23V/jQwd/sDEt/2ZhCjFMwvdKFbk1KDl98=
X-Google-Smtp-Source: APXvYqxrETAgwgqDyOIut2BbkFcERr+0ruZYe5PRgsaRBamPSKYs+SljN9MSQbBp9DY9e2FF5uI137yKpLQYohaK38U=
X-Received: by 2002:a9d:5f89:: with SMTP id g9mr2879670oti.227.1572500107066;
 Wed, 30 Oct 2019 22:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-13-harshadshirwadkar@gmail.com> <20191018015655.GB21137@mit.edu>
In-Reply-To: <20191018015655.GB21137@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 30 Oct 2019 22:34:56 -0700
Message-ID: <CAD+ocbwV+f_sp9-oJyaX=9xvj_DXgLzcXu3CohVEaLDuOSx0hA@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] docs: Add fast commit documentation
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks good point. I was trying to imitate how a jbd2 commit I guess.
There's no reason really to do this in atomic way. I'll fix this in
next version.

On Thu, Oct 17, 2019 at 6:56 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Oct 01, 2019 at 12:41:01AM -0700, Harshad Shirwadkar wrote:
> > +
> > +Multiple fast commit blocks are a part of one sub-transaction. To
> > +indicate the last block in a fast commit transaction, fc_flags field
> > +in the last block in every subtransaction is marked with "LAST" (0x1)
> > +flag. A subtransaction is valid only if all the following conditions
> > +are met:
> > +
> > +1) SUBTID of all blocks is either equal to or greater than SUBTID of
> > +   the previous fast commit block.
> > +2) For every sub-transaction, last block is marked with LAST flag.
> > +3) There are no invalid blocks in between.
>
> I'm wondering why we need to support multiple inodes being modified in
> a single transaction.  As we currently have defined what can be done,
> all updates to an inode should be free standing and not dependent on a
> change to another inode, right?  And today, one block only modifies
> one inode.
>
> The only reason why we might want to define a sub-transaction as being
> composed of multiple inodes, which must all be updated in an
> all-or-nothing fashion, is the swap boot inode ioctl, and if that's
> the only one, I wonder if it's worth the extra complexity.
>
> Am I missing anything?
>
>                                         - Ted
