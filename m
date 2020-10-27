Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24729C4F4
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 19:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823966AbgJ0SBP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Oct 2020 14:01:15 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37088 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1823956AbgJ0SBF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Oct 2020 14:01:05 -0400
Received: by mail-ej1-f67.google.com with SMTP id p9so3540749eji.4
        for <linux-ext4@vger.kernel.org>; Tue, 27 Oct 2020 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GEl6E0e0p4EV61X36fKF8GZsP0/NttcxUtb8/BC5qU=;
        b=pUpzP8JF5OtoMg7kiEW3Llgu3nnJGbNA/i4RgMqMODisMargRY69Z94AXWrQNTLfSQ
         JmNwCOtlzrFcAggQHMIRMsHkboAJL/oBjNA+7O5Mwf2PF6eJ4v7igb1r9aBoXgAF0VRa
         pDd/FS7XUbfh82FGzbCGSTavByS4KggLekjNd/547iW1OvdFXeINBsn1kEXJJaIV3gdi
         31KWAngmSkgYU1MM+uB474b0MlZMpLmIX68+QRelWdFtIMrNGqhg5PVoc6naB9Vvr8jz
         +SV255ZRxXlFOZSsMqc292jp8g/m1WBPFrNZHRjfmLgLqC4JvlJQANPt7rIyd+8LzA47
         BVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GEl6E0e0p4EV61X36fKF8GZsP0/NttcxUtb8/BC5qU=;
        b=mBQa3O1kfOi0JAXq5WxGpYeOG7Q0o66/5hvccottyjo4lW8RhZ7Z9ThnayY5uvee6w
         UX1JcxWAArjsMLzRUTgULfhR32JzxG1o89aN0E4k2svbpBrTFKFsaB3CYDp7LAM+7bb8
         Jl7S6VANeWhA0UoG1siteuTvwPqeJYxDCIb8+p18F6c8W+3Ex7c9r0zk4wql/4ZMBAPk
         1MEWsrXdTWBGWcwHQX/frHAlvwgTLVMLAeTO5b4vW0LOp0X8LoyubrPTuC2uHvc4G/4R
         KLvfuy3ccUL02lf6qJ0/7N95e2vpNkt+Bk9j62po0QsGa4INa6wxgJ1QdOnMO6zDHtHj
         k3Tw==
X-Gm-Message-State: AOAM530Uk9yY3ouEYdq9l4Hp65lGfKj5ON04QNdLtx4lsQJ3qbpGTFBk
        IhuiK5aMCN9NYzKYpWgVJxNFmrPtP4TLM7j0mRjCnQwBKXg=
X-Google-Smtp-Source: ABdhPJzWVwEbwZ1HfaO/caQJZmL7G/b9kob0+/VLd0jv3fPmrtVaAekcvuWhxMKBtJ4fRSAc/YKMWehcldfj9hpgH8I=
X-Received: by 2002:a17:906:640d:: with SMTP id d13mr3464782ejm.223.1603821662773;
 Tue, 27 Oct 2020 11:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201027080954.GA2513442@mwanda>
In-Reply-To: <20201027080954.GA2513442@mwanda>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 27 Oct 2020 11:00:51 -0700
Message-ID: <CAD+ocbxnLG_h4HeQUV8yN-=uYet3V8Yv8gNEGuJaGVGobdekYw@mail.gmail.com>
Subject: Re: [bug report] ext4: fast commit recovery path
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Dan,

On Tue, Oct 27, 2020 at 1:10 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Harshad Shirwadkar,
>
> The patch 8016e29f4362: "ext4: fast commit recovery path" from Oct
> 15, 2020, leads to the following static checker warning:
>
>         fs/ext4/fast_commit.c:1620 ext4_fc_replay_add_range()
>         warn: 'path' is an error pointer or valid
>
> fs/ext4/fast_commit.c
>   1600          cur = start;
>   1601          remaining = len;
>   1602          jbd_debug(1, "ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
>   1603                    start, start_pblk, len, ext4_ext_is_unwritten(ex),
>   1604                    inode->i_ino);
>   1605
>   1606          while (remaining > 0) {
>   1607                  map.m_lblk = cur;
>   1608                  map.m_len = remaining;
>   1609                  map.m_pblk = 0;
>   1610                  ret = ext4_map_blocks(NULL, inode, &map, 0);
>   1611
>   1612                  if (ret < 0) {
>   1613                          iput(inode);
>   1614                          return 0;
>   1615                  }
>   1616
>   1617                  if (ret == 0) {
>   1618                          /* Range is not mapped */
>   1619                          path = ext4_find_extent(inode, cur, NULL, 0);
>   1620                          if (!path)
>   1621                                  continue;
>                                 ^^^^^^^^^^^^^^^^
> "path" can't be NULL, this should be an IS_ERR() test.  It's sort of
> surprising to me that we continue here instead of returning an error.
Thanks for pointing this out. We should check using IS_ERR() here.
Also, I agree that instead of "continue" we should be returning an
error. If not we'd be stuck in this loop forever.

Thanks,
Harshad
>
>   1622                          memset(&newex, 0, sizeof(newex));
>   1623                          newex.ee_block = cpu_to_le32(cur);
>   1624                          ext4_ext_store_pblock(
>   1625                                  &newex, start_pblk + cur - start);
>   1626                          newex.ee_len = cpu_to_le16(map.m_len);
>   1627                          if (ext4_ext_is_unwritten(ex))
>   1628                                  ext4_ext_mark_unwritten(&newex);
>   1629                          down_write(&EXT4_I(inode)->i_data_sem);
>   1630                          ret = ext4_ext_insert_extent(
>   1631                                  NULL, inode, &path, &newex, 0);
>   1632                          up_write((&EXT4_I(inode)->i_data_sem));
>   1633                          ext4_ext_drop_refs(path);
>   1634                          kfree(path);
>   1635                          if (ret) {
>   1636                                  iput(inode);
>   1637                                  return 0;
>   1638                          }
>   1639                          goto next;
>   1640                  }
>   1641
>   1642                  if (start_pblk + cur - start != map.m_pblk) {
>
> regards,
> dan carpenter
