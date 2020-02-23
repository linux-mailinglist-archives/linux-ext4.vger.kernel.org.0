Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB116991B
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Feb 2020 18:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgBWRkY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Feb 2020 12:40:24 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:54409 "EHLO mail.acc.umu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWRkY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 23 Feb 2020 12:40:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by amavisd-new (Postfix) with ESMTP id 06BAF44B97
        for <linux-ext4@vger.kernel.org>; Sun, 23 Feb 2020 18:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=acc.umu.se; s=mail1;
        t=1582479622; bh=XVtFY6TZ90ifmAeaY6rGHfC5Uz2gPQbbpKv881u0+zs=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=tJADDVT5iQtUckmx0NRFtNu39Mk2Bwd9F0zdexYnTKtdw5RW5QqoLU/HR9UJZjgoc
         Fxogc+0Pz/49Eo57H0sBlDG1emhY9uN6FezrEwufF6RPyXuEvHMfPQWyxwui4SOuXa
         1/1IQy/SDRKlLLfk7cA5BrsValr4GmsPhmd0SkNHfuCaLs9j2/Dbi52J4706bteihN
         nLCMRn1KAEqEGta5JCvhV3uIa7Kgdg0omgtOQCx7Awj4h6kNgEV0d9jOal8OIwGFdY
         BIcnWKIN636yU0j4d/13+Zmd1it24wTbRzIzdw/0C6tiptV5+s2GcAqsiakImV6Ibo
         0g+STiMoM9Jmw==
Received: from stalin.acc.umu.se (stalin.acc.umu.se [130.239.18.135])
        by mail.acc.umu.se (Postfix) with ESMTP id 641C544B93
        for <linux-ext4@vger.kernel.org>; Sun, 23 Feb 2020 18:40:21 +0100 (CET)
Received: by stalin.acc.umu.se (Postfix, from userid 10005)
        id 5412121B1B; Sun, 23 Feb 2020 18:40:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by stalin.acc.umu.se (Postfix) with ESMTP id 4CA6821B1A
        for <linux-ext4@vger.kernel.org>; Sun, 23 Feb 2020 18:40:21 +0100 (CET)
Date:   Sun, 23 Feb 2020 18:40:21 +0100 (CET)
From:   Bo Branten <bosse@acc.umu.se>
To:     linux-ext4@vger.kernel.org
Subject: Re: A question on directory checksums
In-Reply-To: <alpine.DEB.2.21.2002221122100.23269@stalin.acc.umu.se>
Message-ID: <alpine.DEB.2.21.2002231833120.135389@stalin.acc.umu.se>
References: <alpine.DEB.2.21.2002221122100.23269@stalin.acc.umu.se>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 22 Feb 2020, Bo Branten wrote:

> /dev/sdb2: Directory inode 64, block #0, offset 0: directory has no checksum.

I think I should tell you how I solved this: It was a good advice to use 
debugfs, with it I could dump the directory block before and after running 
e2fsck and then I found out that it was rec_len in the last directory 
entry in a block that we did not initialize correctly, before it should 
extend to the end of the block but with cecksums we should subtract 
sizeof(struct ext4_dir_entry_tail) from it, thats why e2fsck did not look 
at the checksum even if it was there.

Thank you for youre help.

Bo Branten

