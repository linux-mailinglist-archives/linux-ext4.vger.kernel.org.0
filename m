Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A2D449EF0
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Nov 2021 00:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhKHXMF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Nov 2021 18:12:05 -0500
Received: from mimmi.uddeborg.se ([62.65.125.225]:50144 "EHLO
        mimmi.uddeborg.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhKHXMF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Nov 2021 18:12:05 -0500
X-Greylist: delayed 3244 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2021 18:12:04 EST
Received: from mimmi.uddeborg (localhost [127.0.0.1])
        by mimmi.uddeborg.se (8.15.2/8.15.2) with ESMTPS id 1A8MFE5u361650
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <linux-ext4@vger.kernel.org>; Mon, 8 Nov 2021 23:15:14 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 mimmi.uddeborg.se 1A8MFE5u361650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uddeborg.se;
        s=default; t=1636409714; r=y;
        bh=ZmKGOmABl3k/gifRD3meq80kFVQ4Z4soQvQTWgEgpds=;
        h=Date:From:To:Subject:From;
        b=GPrp+Ea9fYkZ2teJXp0/uqFLzSwIFi67LvhbqqzyWiiPY9zkQnWrzT6HINbrKRlee
         ocL5FZQN1ldXpoZqOifxMzZlrAPOhFJxzv960sioLXB9KqnNMrde8NIdO4J3mOR6K5
         aIfMrLI2lbilOXnJsWOSOedtIOdolm9L7eh53eAQ=
Received: (from goeran@localhost)
        by mimmi.uddeborg (8.15.2/8.15.2/Submit) id 1A8MFDGk361649;
        Mon, 8 Nov 2021 23:15:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24969.41329.680145.538898@gargle.gargle.HOWL>
Date:   Mon, 8 Nov 2021 23:15:13 +0100
From:   =?utf-8?Q?G=C3=B6ran?= Uddeborg <goeran@uddeborg.se>
To:     linux-ext4@vger.kernel.org
Subject: Contents of files exchanged
X-Mailer: VM 8.2.0b under 26.2 (x86_64-redhat-linux-gnu)
X-Face: Y!dkPRvB0]![*xB\M-!MfkgZ"n-BHD$BA(TZCt2r%n^o6|o1dWGQnY1<Y4}|@3?LNnN])Lp
        SKhC?f4OE*BqS>T)l5dc&vd#fDAE#]Dk;{]D@+o+?X(RqRh{#-D^87?5uml$Phvma*@_~1OS(i`D.v
        &0;f<h{bI;v5]m?&\Qh06/0CP6O$1MkZJR_~XTYm~cAwU($ioR86{'%h
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAKlBMVEUkIEVaTSwADXunZTaDcoNz
        SS8bJn4cQcTi2rrjx3JYLCkhM6DXlXwkGQn7wQfSAAACXUlEQVQ4jW3TP2sbMRQA8HRt6CCCFtOC
        yeAh0KGoN7iom0uGdDmElpvcEDIYMucLFHo3O6WnVosIWgS3dPFw49nYIhqaocuBvkufzr6zz/Rh
        L/ohvz9+OjnfxjV8yxCL+22cnLcxup0qvLm6P4LR1JgBYpv0CK5fFs94ghjfPPVhWngfa4aeH5c9
        GL7y3vP4jBfYTg7gFsF5fRYxGumxXO/h5o2vDScVFSJiIu9ghIpacUKtSNO5tptvLXypfY0ZsSJP
        0+zD2H1tATIbzogLkM5fz+XlDiCzagDO0yyu7A6GDcB5A+mKfP4/fEeTdQe1biDkSOdocnkALFQb
        7mTy3WSfvNaEEOqczQE+HQImHOoCzFPxfrno+qhxbGAmUcJcDtA2+NYbhAde0USzygo+aWHojYq9
        /5snpqZUxFfddL0xhS90vlL1gIrIHdwo6sLoXEJ6IuJ2JCFHCL4RFYxYcNJWdQeAYwwQmhekm+5d
        YTCHPvIMIBOVaGFmwt/BHzcAqRCrcQsXcIORRFMh4cfknK5bMFtgdDUGyLqqhsYgHhmjjWNW2ixr
        qxopozhPIJGIqLR51nWuB4Zz+EAS5oTN95A0fcChrJy0PzqYFQYhHRalonZ+szjYdoUG0D5UTO1D
        7xkoFBfeMCukXfbgRcy5pi7AUw9mMeLNMkrXhwuEQDixzv3qwUihMGBo5AggOwoXApQ9gEYwg2WU
        9BiMwvCoHKEP5aIHsFuhLgZQLg6h8ApxFMPcf5+c7gHmAQ8X8kD+n/5P2QIs0ACWTiEGzYuP/rTc
        ATwpFLLjBgRcKf8B/C7q8i6VUCAAAAAASUVORK5CYII=
X-URL:  http://www.uddeborg.se/g%C3%B6ran/
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Is a "user question" acceptable on this list?

When helping a friend with a system that wouldn't boot, we
investigated the file system from a live image. It turned out that a
lot of files had had their contents replaced with a completely
different file's contents. As an example, the libuuid.so.1.3.0 file
had the contents of the README file from the zfs-fuse package. They
still had different inode numbers; they were not links to the same.
There were at least dozens of files "replaced" in that way, we stopped
searching after fixing a few.

This started after an abrupt unplanned power loss, so a fsck on reboot
was expected. But how could it possibly have such a drastic effect?

In case it is relevant, it was on a Fedora 34, initially installed
before btrfs was default on Fedora, and upgraded since.
