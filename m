Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962BE438335
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Oct 2021 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhJWKci (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 Oct 2021 06:32:38 -0400
Received: from mx1.tetaneutral.net ([91.224.149.83]:46766 "EHLO
        mx1.tetaneutral.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJWKch (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 Oct 2021 06:32:37 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Oct 2021 06:32:37 EDT
Received: by mx1.tetaneutral.net (Postfix, from userid 109)
        id 7F5568C0D4; Sat, 23 Oct 2021 12:24:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mx1.tetaneutral.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1
        autolearn=ham autolearn_force=no version=3.4.2
Received: from lgnuc (ip165.tetaneutral.net [IPv6:2a03:7220:8080:a500::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.tetaneutral.net (Postfix) with ESMTPS id 8C9B88C0CC
        for <linux-ext4@vger.kernel.org>; Sat, 23 Oct 2021 12:24:41 +0200 (CEST)
Message-ID: <1634984680.26818.10.camel@guerby.net>
Subject: How to force EXT4_MB_GRP_CLEAR_TRIMMED on a live ext4?
From:   Laurent GUERBY <laurent@guerby.net>
To:     linux-ext4@vger.kernel.org
Date:   Sat, 23 Oct 2021 12:24:40 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

When using fstrim on an ext4 filesystem trim are not issued for
EXT4_MB_GRP_WAS_TRIMMED space which is a useful optimization.

Is there a way to force a complete trim on a mounted ext4 filesystem? 

My (limited) understanding of the code is that
EXT4_MB_GRP_CLEAR_TRIMMED should be called to do so.

My use case is having live migrated a virtual machine root disk from
one storage to another, the target supporting trim, but since fstrim in
the VM post migration does mostly nothing (assumes most space was
trimmed) I cannot release space to the new storage.

I tried mount -o remount but without effect. e2fsprogs don't seem to
have an option/tool to do this either.

I've seen suggestion that rebooting will do the job but the whole point
of live migration is to avoid reboot :).

I did end up creating dummy files to fill the filesystem and then
removing them, but this is far less efficient than what a filesystem
tool could do.

Thanks in advance for your help,

Sincerely,

Laurent

