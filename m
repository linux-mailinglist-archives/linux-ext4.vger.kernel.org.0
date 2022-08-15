Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB28592EFA
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiHOMhS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Aug 2022 08:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHOMhR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Aug 2022 08:37:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433C1A3BC;
        Mon, 15 Aug 2022 05:37:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i14so13280157ejg.6;
        Mon, 15 Aug 2022 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iiJ9o815tXNLizpE07FEy8fz7HVKa6/gr4/C8XpAKFM=;
        b=DUDguRwqkZJiBAsp7o+6vNS7DAbUk6Heh40+HHDlyvdVPDn4feugxqREyaI4FnZKzx
         42EZDKSt2/YAXV39o3IUvr/y3EjM/1lC3NhSfZGexVcu0NWNINYhon1dqwz9QkTX6VJc
         1tOf4hKbHC9l79/LvnYxIqRO7do38EIAk302EMK6jb6Y4RH6z6vpYx8Cnl5AzD9SGMT9
         eVV4C7J9fcEiOuzYv1i9bvFYYFio0nqNISVK9zxg6wEf1quZD3hX1P/EvwgOSwdMVsUy
         UyE5Sbq4YBQ+zhsWJlfDq4sXeEF2BTck1iAFdhMRyWub8qBg3RKmjs0ETPr4fOf5GDFJ
         1oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iiJ9o815tXNLizpE07FEy8fz7HVKa6/gr4/C8XpAKFM=;
        b=dra27DPdwiBXTyIG4GokKfgPHcGtV0njrHpfFEIDeVEwto5vq2dpBWHbC6VyNzAUwK
         NA1ftmBPsFMx7f0YS2Fwk6t24BhJyez9hScvqzbr+EpW/b2FVdWzHORiqM6IkgmplZRI
         Yn89fTKuH8LmbffmJzJrk/Zu863MH3PnYng6yvZZfs1xAwACPf3A/1EOVoHqIGudtxxz
         tIOBIyvyWBmVmBAQdzURThKZO4+IdozL1F3NIae6J6zI9kKeQ5CzocZ3qGPLTTw+oB0o
         7IW/6lsP3e3FZokMd4GEZcpNIBbRvitdETS6Edpe1fcCYvWiOQAEOSUFuT/jw/C5mjli
         1Z2w==
X-Gm-Message-State: ACgBeo3SgEIqR/BIliHZGmrHTBwFLcRbOCqCvzmOz+ObSnDicuZBb/1c
        B/dNDrjqPDVGd/J+1+LQSlmob1d/fqT/+TM+6cM=
X-Google-Smtp-Source: AA6agR7L4fua/J012BLnw+UAlYRm46HxJBqezM5RMJyPguk2IasF76eudVUjir/cn5WvLjTENhlHsIWwSL5WlMvPztc=
X-Received: by 2002:a17:907:7fa0:b0:730:c9aa:b4a7 with SMTP id
 qk32-20020a1709077fa000b00730c9aab4a7mr10414162ejc.322.1660567034588; Mon, 15
 Aug 2022 05:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220814090016.3160-1-sunjunchao2870@gmail.com> <YvoQIvIlMsADeG2H@debian.me>
In-Reply-To: <YvoQIvIlMsADeG2H@debian.me>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Mon, 15 Aug 2022 20:37:02 +0800
Message-ID: <CAHB1NahR=LrtTu+J6_puHZU63q3TwhrvA9yDNs2C5LJa4kugmA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ext4: correct the document about superblock
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        tytso@mit.edu, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your suggestions, I will send patchv2.

On Mon, Aug 15, 2022 at 5:21 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Sun, Aug 14, 2022 at 02:00:16AM -0700, JunChao Sun wrote:
> > Correct some questions like this:
> > s_lastcheck_hi field should be upper 8 bits of the
> > s_lastcheck field, rather than itself.
> >
> > diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
> > index 268888522e35..0152888cac29 100644
> > --- a/Documentation/filesystems/ext4/super.rst
> > +++ b/Documentation/filesystems/ext4/super.rst
> > @@ -456,15 +456,15 @@ The ext4 superblock is laid out as follows in
> >     * - 0x277
> >       - __u8
> >       - s_lastcheck_hi
> > -     - Upper 8 bits of the s_lastcheck_hi field.
> > +     - Upper 8 bits of the s_lastcheck field.
> >     * - 0x278
> >       - __u8
> >       - s_first_error_time_hi
> > -     - Upper 8 bits of the s_first_error_time_hi field.
> > +     - Upper 8 bits of the s_first_error_time field.
> >     * - 0x279
> >       - __u8
> >       - s_last_error_time_hi
> > -     - Upper 8 bits of the s_last_error_time_hi field.
> > +     - Upper 8 bits of the s_last_error_time field.
> >     * - 0x27A
> >       - __u8
> >       - s_pad[2]
>
> The diff looks OK, but the description should be:
> "The description of s_lastcheck_hi, s_first_error_time_hi, and
> s_last_error_time_hi fields refer to themselves, while these means
> referring to upper 8 bits (byte) of corresponding fields (s_lastcheck,
> s_first_error_time, and s_last_error_time). Correct the mistake."
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
