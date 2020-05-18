Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F4F1D8915
	for <lists+linux-ext4@lfdr.de>; Mon, 18 May 2020 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgERUWa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 18 May 2020 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgERUW3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 May 2020 16:22:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5869C061A0C
        for <linux-ext4@vger.kernel.org>; Mon, 18 May 2020 13:22:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1F3492A02BD
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [GIT PULL] Unicode updates for v5.8
Date:   Mon, 18 May 2020 16:22:24 -0400
Message-ID: <85a725f0xr.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


The following changes since commit 9c94b39560c3a013de5886ea21ef1eaf21840cb9:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2020-04-05 10:54:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-v5.8

for you to fetch changes up to cfeb007a96b15cafe1b8cc7aa8d43da77a97b7ae:

  unicode: Expose available encodings in sysfs (2020-05-18 15:07:13 -0400)

----------------------------------------------------------------
fs/unicode patches for v5.8

This includes two patches for the unicode system for inclusion into
Linux v5.8:

  - A patch from Gabriel exporting in sysfs the most recent utf-8
  version available

  - A patch by Ricardo Cañuelo converting the unicode tests to kunit.

----------------------------------------------------------------
Gabriel Krisman Bertazi (1):
      unicode: Expose available encodings in sysfs

Ricardo Cañuelo (1):
      unicode: implement utf8 unit tests as a KUnit test suite.

 Documentation/ABI/testing/sysfs-fs-unicode  |   6 +
 fs/unicode/Kconfig                          |  19 ++-
 fs/unicode/Makefile                         |   2 +-
 fs/unicode/utf8-core.c                      |  55 ++++++++
 fs/unicode/{utf8-selftest.c => utf8-test.c} | 199 +++++++++++++---------------
 fs/unicode/utf8n.h                          |   4 +
 6 files changed, 173 insertions(+), 112 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-unicode
 rename fs/unicode/{utf8-selftest.c => utf8-test.c} (60%)


-- 
Gabriel Krisman Bertazi
