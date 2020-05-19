Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6139F1D8F0A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 May 2020 07:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgESFJ0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 May 2020 01:09:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47146 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgESFJ0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 May 2020 01:09:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DE34A2A0A92
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] Unicode updates for v5.8
Organization: Collabora
References: <85a725f0xr.fsf@collabora.com>
Date:   Tue, 19 May 2020 01:09:21 -0400
In-Reply-To: <85a725f0xr.fsf@collabora.com> (Gabriel Krisman Bertazi's message
        of "Mon, 18 May 2020 16:22:24 -0400")
Message-ID: <85v9ksecji.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> The following changes since commit 9c94b39560c3a013de5886ea21ef1eaf21840cb9:
>
>   Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2020-04-05 10:54:03 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-v5.8
>
> for you to fetch changes up to cfeb007a96b15cafe1b8cc7aa8d43da77a97b7ae:
>
>   unicode: Expose available encodings in sysfs (2020-05-18 15:07:13 -0400)
>

Ted,

I just found that the patch converting the utf8 selftests to kunit
breaks the allmodconfig build, since kunit itself started to support
module builds recently.  I just submitted a patch in linux-ext4 that
fixes this, and if there is no concerns, I will get you a new pull
request with the fix included.

Sorry for the noise.

-- 
Gabriel Krisman Bertazi
