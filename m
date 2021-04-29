Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9C36E483
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 07:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhD2Feg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 01:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhD2Fef (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 01:34:35 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40BDC06138B
        for <linux-ext4@vger.kernel.org>; Wed, 28 Apr 2021 22:33:47 -0700 (PDT)
Received: from vapier (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id D59F833D3CF
        for <linux-ext4@vger.kernel.org>; Thu, 29 Apr 2021 05:33:45 +0000 (UTC)
Date:   Thu, 29 Apr 2021 01:33:38 -0400
From:   Mike Frysinger <vapier@gentoo.org>
To:     linux-ext4@vger.kernel.org
Subject: e4defrag seems too optimistic
Message-ID: <YIpFK3or2Creo1qg@vapier>
Mail-Followup-To: linux-ext4@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

i started running e4defrag out of curiosity on some large files that i'm
archiving long term.  its results seem exceedingly optimistic and i have
a hard time agreeing with it.  am i pessimistic ?

for example, i have a ~4GB archive:
$ e4defrag -c ./foo.tar.xz
<File>                                         now/best       size/ext
./foo.tar.xz
                                             39442/2             93 KB

 Total/best extents				39442/2
 Average size per extent			93 KB
 Fragmentation score				34
 [0-30 no problem: 31-55 a little bit fragmented: 56- needs defrag]
 This file (./foo.tar.xz) does not need defragmentation.
 Done.

i have a real hard time seeing this file as barely "a little bit fragmented".
shouldn't the fragmentation score be higher ?

as a measure of "how fragmented is it really", if i copy the file and then
delete the original, there's a noticeable delay before `rm` finishes.
-mike
