Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE6168E4F
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2020 11:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgBVKqA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Feb 2020 05:46:00 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:40306 "EHLO mail.acc.umu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgBVKqA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 22 Feb 2020 05:46:00 -0500
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Feb 2020 05:45:59 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by amavisd-new (Postfix) with ESMTP id 5474144B93
        for <linux-ext4@vger.kernel.org>; Sat, 22 Feb 2020 11:36:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=acc.umu.se; s=mail1;
        t=1582367804; bh=ldernLYjuXwpECkDEd1R3DvHTk64KLGprWnrkHgEUhU=;
        h=Date:From:To:Subject:From;
        b=QZYz074H0V9TrS/5ItMdPT7YOYPDGgsy5Kng8Twrrqv4m+rr3Kkeb2POnJXo7T4Xj
         Eeq9ln+eW6l4OzKUV9omBtg1fwpBGLcsWhsTrlsL98NnPBitaIS3MhJzDcwklIiSX9
         hRyFiME3NkSrHyQd2oHibWvEKpV0wG2dqcjtOp4IO1qFnTICYKTS0UcSBxSzOcaklh
         5RuRY/AsXrad65VGlGWyvjsdv4XIvNkee0YskjsN9gS5n+GEr9k442Z+PaAIXirUKf
         0hLB+GWxTQc6F693tjPyp0whWvL+OVa851ULQDBb9Z8mLxEQLWpmpbpJ4cmuWMD7ZB
         /zkeI9HX0VtAQ==
Received: from stalin.acc.umu.se (stalin.acc.umu.se [130.239.18.135])
        by mail.acc.umu.se (Postfix) with ESMTP id AA35D44B90
        for <linux-ext4@vger.kernel.org>; Sat, 22 Feb 2020 11:36:43 +0100 (CET)
Received: by stalin.acc.umu.se (Postfix, from userid 10005)
        id 9D4BB21B1B; Sat, 22 Feb 2020 11:36:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by stalin.acc.umu.se (Postfix) with ESMTP id 9968121B1A
        for <linux-ext4@vger.kernel.org>; Sat, 22 Feb 2020 11:36:43 +0100 (CET)
Date:   Sat, 22 Feb 2020 11:36:43 +0100 (CET)
From:   Bo Branten <bosse@acc.umu.se>
To:     linux-ext4@vger.kernel.org
Subject: A question on directory checksums
Message-ID: <alpine.DEB.2.21.2002221122100.23269@stalin.acc.umu.se>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hello,

I am implementing support for metadata checksums on an ext4 driver for 
another os and test this by writing something and then run e2fsck from 
Linux to see what it says. When I create a new empty directory that only 
contains . and .. I got this error message from e2fsck that I want to ask 
you to clearify:

bo@bo-desktop:~$ sudo e2fsck -pvf /dev/sdb2
/dev/sdb2: Directory inode 64, block #0, offset 0: directory has no checksum.
FIXED.

Am I right that it is not the checksum on the inode that represents the 
directory but the checksum in the directory entry tail in the first and 
only block?

Also do "no checksum" means something different than wrong checksum, like 
I have not initialized it correctly? (if I dont call 
initialize_dirent_tail I will get another error message from e2fsck that 
speficially says there is no room for the checksum so it can not be that)

Bo Branten
