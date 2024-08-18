Return-Path: <linux-ext4+bounces-3769-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD2955AF5
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA23A1C20A96
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225A9454;
	Sun, 18 Aug 2024 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0YdE5fY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5223AD
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723956564; cv=none; b=EVPXDlQzGYgcbESlJQPrFKxwZDN6hWvyUa+TG7Z85aTORxmrrqf27ICzrmTUM/UqhV1KXX076+nF6mY2k0LYgTHkkRI3GRK+O7I0VCSULvLnRdGe7plE0wQUmszoqibZGnGiwqpvL02ORbpA//sacd4k/HtePtWt82VOS4foiYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723956564; c=relaxed/simple;
	bh=PQVdP80oYMkQWa6Mw8G5eg0q2/0zhP5T9AmD+lD2PSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5uWVG/SKME+Abm3P+eur7uQUqQGaJFT0zJ/BpRgv9NpcpDECoQQNLNYtAqa6gLtOjhIBS7yE1l4dl32eivKLZ6pB5G86ATtjm6jtD7zNeuDnU22VeMnBYSpzUc7LFWhYuVWyKzbTKY2LDNKxiL5IAHGVCORuTkyfB30xtMkLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0YdE5fY; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0e76380433so3390299276.2
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723956562; x=1724561362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9Qh7f37uw0M7h8kMBvDd6mxhjcmMWVgK+Pd3D7QGaw=;
        b=D0YdE5fYc6Fogm3eNKbOBHb41vn94qqSNmd5Nai7T2Y74tWp5RkVIqzK1YF2rNrnVi
         27AZBXgjkgunAhW2SFXR+NtFeZwVlRJH2e+YesAAK7z163RT1LHCQLRgu038UCarW/w6
         dxcctwwd0MvR0R4L6VIOCGV3e+erM+4pFFte3hwl1Z8nDQYDZkn6y3UGl0q9m98sd8Wh
         S7Y+++9nVz2LEFtWMl34DCK1lRSDPMeVgQcrBJNf5w9YzU3eeVzRZrhgGPyCegIqYr2H
         jmKrK4e3q+btg696pJROgqWwTx21byYnT4+SDKJcvzZbJ52FgDCnS3J1itxWiXvugW26
         XuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723956562; x=1724561362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9Qh7f37uw0M7h8kMBvDd6mxhjcmMWVgK+Pd3D7QGaw=;
        b=E502nRZ+SpceBBjEJID9D8enVSr7tVhp55nYVieXLJV9UY1KXZEC9HCyoUpq6+MeWa
         41tIo6vF0gn5wuHavOEpHvq3E/7KJJ+tCaki+prpoWrdpduMREa6qVaOUz+hRn5blXZ2
         FECJHcfog9Ja47Mc8NpfjE9WTRmHo0AcIX4OCcyxgnt4/u9cQljB0kgJ4H3GO9FtE9Tf
         IfVbh973iEes6IEgbcyobKwuiNtYoaUAoiKHUYB9xD/Ry12hyAgvSrCOgqZLujiuv49x
         QSWViYpPcALewNn1O9rEQ5Jnj9Jnm4vRzjG9WlI4gpdGKn6wbyJHIaLIThmybMaQheKj
         Rbng==
X-Gm-Message-State: AOJu0YzJeXeBFb7Rj6A/vbsGRPR7vWyaLa93LDKSsVyfTKHkAptQrnvi
	JFO0qpLyNQZPm1PJ8VkUOW4KEOymx7SS6Hq+BjWQ69kkhDaoUPy9g2b9U/01VWUMUJcfBR5jJ0q
	bGAXXq1TCSPyBZ6jVYx/h4D2zszLCztppgnx4u04n
X-Google-Smtp-Source: AGHT+IFk7y998Wn1Ht15ql6mCgZxoPzIxZATJ1lWZqvyZTQpm2Ljjfy+g5+9nltE7hTVkvMbMRXAKkGvQ3PUlX1tC/Q=
X-Received: by 2002:a05:6902:1189:b0:e11:7bff:364f with SMTP id
 3f1490d57ef6-e1180f0aedamr7357037276.25.1723956561712; Sat, 17 Aug 2024
 21:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com> <20240818040356.241684-2-harshadshirwadkar@gmail.com>
In-Reply-To: <20240818040356.241684-2-harshadshirwadkar@gmail.com>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Sat, 17 Aug 2024 21:49:09 -0700
Message-ID: <CAD+ocbzWreiFGgQDcT6posPe-jTBvm=TQK-16GJ-6Oc3+GLETw@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Ext4 Fast Commit Performance Patchset
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, jack@suse.cz, harshads@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 9:04=E2=80=AFPM Harshad Shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> V7 Cover Letter
> ---------------
>
> This is the V7 of the patch series. This patch series contains fixes to
> review comments by Jan Kara (<jack@suse.cz>). The main changes are as
> follows:
>
> - As discussed in V6 review, I have dropped "ext4: add nolock mode to
>   ext4_map_blocks()" patch given that we now ensure that i_data_sem is
>   always grabbed before ext4_mark_inode_dirty() is called.
>
> - I have also dropped "ext4: introduce selective flushing in fast commit"
>   given that correctly implementing that would require more changes, and =
I
>   think they would be best done outside of this series.
>
> - I added "ext4: introduce selective flushing in fast commit" as the last
>   patch in the series. While testing log group tests I found a few failur=
es
>   which get fixed due to this patch.

Sorry that was a copy paste error. I meant to say I have added a new
patch - "ext4: hold s_fc_lock while during fast commit" (which is the
last patch in the series).

- Harshad

>
> V6 Cover Letter
> ---------------
>
> This is the V6 of the patch series. This patch series contains fixes to a
> bunch of kernel build warnings reported by Kernel Test Robot
> (lkp@intel.com) and Dan Carpenter (dan.carpenter@linaro.org). Thank you!
>
> V5 Cover Letter
> ---------------
>
> This patch series supersedes the patch series "ext4: remove journal barri=
er
> during fast commit" sent in July 2022[1].  Except following three patches
> all the other patches are newly introduced in this series.
>
> * ext4: convert i_fc_lock to spinlock
> * ext4: for committing inode, make ext4_fc_track_inode wait
> * ext4: drop i_fc_updates from inode fc info
>
> This patchset does not introduce any on-disk format and / or user visible
> API change. This patchset reworks fast-commit's commit path improve overa=
ll
> performance of the commit path. Following optimizations have been added i=
n
> this series:
>
> * Avoid having to lock the journal throughout the fast commit.
> * Remove tracking of open handles per inode.
> * Avoid issuing cache flushes when fast commits are contained within a
>   single FUA writes and there is no data that needs flushing.
> * Temporarily lift committing thread's priority to match that of the
>   journal thread to reduce scheduling delays.
>
> With the changes introduced in this patch series, now the commit path for
> fast commits is as follows:
>
> 1. Lock the journal by calling jbd2_journal_lock_updates_no_rsv(). This
>    ensures that all the exsiting handles finish and no new handles can
>    start.
> 2. Mark all the fast commit eligible inodes as undergoing fast commit by
>    setting "EXT4_STATE_FC_COMMITTING" state.
> 3. Unlock the journal by calling jbd2_journal_unlock_updates. This allows
>    starting of new handles. If new handles try to start an update on any =
of
>    the inodes that are being committed, ext4_fc_track_inode() will block
>    until those inodes have finished the fast commit.
> 4. Submit data buffers of all the committing inodes.
> 5. Wait for [4] to complete.
> 6. Commit all the directory entry updates in the fast commit space.
> 7. Commit all the changed inodes in the fast commit space and clear
>    "EXT4_STATE_FC_COMMITTING" for all the inodes.
> 8. Write tail tag to ensure atomicity of commits.
>
> (The above flow has been documented in the code as well)
>
> I verified that the patch series introduces no regressions in "log" group=
s
> when "fast_commit" feature is enabled.
>
> Also, we have a paper on fast commits in USENIX ATC 2024 this year which
> should become available on the website[2] in a few months.
>
> [1] https://lwn.net/Articles/902022/
> [2] https://www.usenix.org/conference/atc24
>
> Harshad Shirwadkar (9):
>   ext4: convert i_fc_lock to spinlock
>   ext4: for committing inode, make ext4_fc_track_inode wait
>   ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
>   ext4: rework fast commit commit path
>   ext4: drop i_fc_updates from inode fc info
>   ext4: update code documentation
>   ext4: temporarily elevate commit thread priority
>   ext4: make fast commit ineligible on ext4_reserve_inode_write failure
>   ext4: hold s_fc_lock while during fast commit
>
>  fs/ext4/ext4.h              |  18 +-
>  fs/ext4/fast_commit.c       | 339 ++++++++++++++++++------------------
>  fs/ext4/fast_commit.h       |   1 +
>  fs/ext4/inline.c            |   3 +
>  fs/ext4/inode.c             |  38 ++--
>  fs/ext4/super.c             |   9 +-
>  fs/jbd2/journal.c           |   2 -
>  include/trace/events/ext4.h |   7 +-
>  8 files changed, 214 insertions(+), 203 deletions(-)
>
> --
> 2.46.0.184.g6999bdac58-goog
>

