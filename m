Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA73D7E46
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jul 2021 21:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhG0THM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 15:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0THM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 15:07:12 -0400
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [IPv6:2801:82:80ff:7fff::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F678C061757
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jul 2021 12:07:11 -0700 (PDT)
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
        id 4253436303CA; Tue, 27 Jul 2021 16:07:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
        s=201705; t=1627412826;
        bh=8Fh8Q9/DE0Yym9+K9UblkLey6erZgu3lDIsq65qNdxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9RzmSUMYve09Lf8gm9Otg2ovuW812BbiJg6Gsg76p59dAEtnU3N7+F4nJN/TN0K5
         hxCu5tP8T/v1rw2+BHFQz/vel145HmQj10r47a3T3inxNoWFLTFI31aaQED/XcQ2ie
         Adg4TUz7GWWlQa2/iOSF9xmR1Y+61E0A+QR06aAqOyRr/SF4Ye9RyJu2Zq4dLgZCbp
         Sr7kMebG1ykVrwQT7QHZefqHdPdEoCDBFX0QRbOgber0UtOfblViyma9+R+d/W3N6k
         SLY0EnhZnRQNq+M6UC3hXWoEFrcFs/l1BgAkV6mrjM7plN+74/2YUZRhw4Qj7UMUxL
         1iPuIN9CC8ovQ==
Date:   Tue, 27 Jul 2021 16:07:06 -0300
From:   Carlos Carvalho <carlos@fisica.ufpr.br>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: bug with large_dir in 5.12.17
Message-ID: <YQBZWuAN+u+Lfhfo@fisica.ufpr.br>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
 <0FA2DF8F-8F8D-4A54-B21E-73B318C73F4C@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0FA2DF8F-8F8D-4A54-B21E-73B318C73F4C@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas Dilger (adilger@dilger.ca) wrote on Tue, Jul 27, 2021 at 03:22:10AM -03:
> On Jul 22, 2021, at 8:23 AM, Carlos Carvalho <carlos@fisica.ufpr.br> wrote:
> > 
> > There is a bug when enabling large_dir in 5.12.17. I got this during a backup:
> > 
> > index full, reach max htree level :2
> > Large directory feature is not enabled on this filesystem
> > 
> > So I unmounted, ran tune2fs -O large_dir /dev/device and mounted again. However
> > this error appeared:
> > 
> > dx_probe:864: inode #576594294: block 144245: comm rsync: directory leaf block found instead of index block
> > 
> > I unmounted, ran fsck and it "salvaged" a bunch of directories. However at the
> > next backup run the same errors appeared again.
> > 
> > This is with vanilla 5.2.17.
> 
> Hi Carlos,
> are you able to reproduce this error on a new directory that did not hit
> the 2-level htree limit before enabling large_dir, or did you only see this
> with directories that hit the 2-level htree limit before the update?

I removed all directories where the error happens (several hours...) and ran
the backup again, after fsck, and the error was the same, so it also happens in
new ones.

> Did you test on any newer kernels than 5.2.17?

Not yet. The machine is running 5.13.5 now but this particular backup hasn't
run yet. I'm doing fsck now (takes 4h30) and will launch it again.
