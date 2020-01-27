Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F60614A5F1
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2020 15:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgA0OXx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jan 2020 09:23:53 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:34086 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgA0OXx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jan 2020 09:23:53 -0500
Received: by mail-lj1-f175.google.com with SMTP id x7so10837070ljc.1
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2020 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CbnLssdXHmKZv+CXNil5P4hYB7H/C2FtRQDktvuWXfg=;
        b=I7+pFw6O203mk0DttZvLs4kluPRGjpeg6jkSIZhhnnTYvDo7MVy7CVefg+WCgrZ3vG
         P444Qs+YXDGybevFKaneW+bWb3YMkgtVI0ZTXiquQkld4dbU0dptDURnS5py1Y6rPNrk
         CY2K1DagyTyj8uFz5SZpp+WNY89xA1u0hwBzeY24Gz078KsITqVYpRtb/FbhGT9tfTy3
         HdzvAUVwLHEgXpUJFtUann3IxEkiuJ4grZj6jg2QafdzCV9JbQ+1zuhx+lqW9KQasHRM
         InqJocjj/Hh8xJ41mBHUJkWnSv1CD1wg2r2aAnQMykvjagxFrtTkoUfJJCUxZBFeB7wo
         SxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CbnLssdXHmKZv+CXNil5P4hYB7H/C2FtRQDktvuWXfg=;
        b=gmNomCCX0mkqHDQ5fmJrtf1xY2i0WoSW/getaxxDgzcBrXgF9NlrQ6p2mfztqTtCP6
         nmYpsZbZhNehJdtlcIQux5Te8EW/vjJziVZ5zqCjffpjW1Vf3tFOu3AvWL/yF9Q6Dkew
         wGt54j8Fw2lpZT73svopiV/HujQyxJaQg2tEgO3z03A0htxCJXo0pPbG+26mMd9JdXZS
         HqcbmulW54tTrB1GnOujqn1WTpbgYLV7yaHrCcr6lELkvdYa1JyufMGhQqUO47d/De2T
         c20fuXrutSenx4bSCbBqxPF7cE0Kugh2Ksm9RvVVdvMoDEqFPr0zC3oX47sXowWyf9OS
         jzJw==
X-Gm-Message-State: APjAAAWeMI9ysbQgjLk0fLomxJrdrEmlQNKtsIqWbG6e7JE9Xos+NNDB
        Nrk1z3jR1smvJhaPqExZ2V92AXePez4tNFH8EF6cTCYa
X-Google-Smtp-Source: APXvYqwyiF8M2JoRVOe0CQy5G05JyDUaaqFhpcSP3YDQiYnsvt6iAb5V8t3UOdcgMxK4ZDiWBBPKDNcVy/+bqLgBfm0=
X-Received: by 2002:a2e:b5b4:: with SMTP id f20mr4545956ljn.112.1580135031223;
 Mon, 27 Jan 2020 06:23:51 -0800 (PST)
MIME-Version: 1.0
From:   Red Swaqz <redswaqz@gmail.com>
Date:   Mon, 27 Jan 2020 11:26:40 -0300
Message-ID: <CACFo8TH_BPFdCiUZZXJY+VWcvy5reNXEd70PREFm4UCjPGghRQ@mail.gmail.com>
Subject: [QUESTION] jbd2: how metadata blocks are checkpointed by the page-cache?
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello all,

I am studying the ext4/JBD2 internals and there is one thing that is missing
in my understanding: the **Checkpoint** part for metadata blocks.

So far I understood that the JBD2 marks the metadata buffers as
_bufer_jbddirty(bh)_,
then during the commit, the buffers are shadowed, written to the
journal area, and later
they are marked as _buffer_dirty(bh)_ and left to the page-cache to
writeback them
to the original position at the disk. Later on, the JBD2 will check
its checkpoint list
and check if the _buffer_heads_ are clean, which indicates that they
were written to
the storage and the CP operation is complete, thus JBD2 can remove
those _buffer_heads_
from its control.

So, this is the part I didn't catch in the code: where/when/how the
page-cache writes
the metadata blocks exactly? So far I could understand (not 100% sure)
that the ext4
fills the _address_space_operations_ structure with the
_ext4_writepage()_, _ext4_writepages()_,
and so on for the page-cache operations. But still, it is not clear to
me when the metadata
blocks are written back to cause the CP completion.

The writeback part for data blocks is OK because it looks to me that
the page-cache uses
the _inodes_ to be able to write them to the storage (with the data
blocks). So, this is kinda
easy to figure out in the source code.

Anyone could help me with some insights into the source code or maybe theory?

Thank you all.
