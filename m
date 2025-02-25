Return-Path: <linux-ext4+bounces-6564-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C5AA43DA9
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2025 12:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E6A3BCB53
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2025 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05526770C;
	Tue, 25 Feb 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1I2Caj6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD33267AF7
	for <linux-ext4@vger.kernel.org>; Tue, 25 Feb 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482849; cv=none; b=mQYQUg0Q3b+tgVJoZHZzeTOIZBFJVgCjlPpDvjCDZeWUUUvvgg4uAniyEvfYoG8qoLnsBSHSAUlnAFYD4cxjXrQAdYOtnSyeQlqSWC1C7tEyeNYteHjepnW+dnTrAvC0nKTbIx+C2CgDDVjXWNSWXNBtcD6p4IN5dAuT/2SKhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482849; c=relaxed/simple;
	bh=IuPkboj/VRDYDqbsnZlMgC9dYO3zbpd8HgTSHhaGRmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AO7xXr9iYHilkqDhZSegMMqM3zcZzB0tCpDidz5sgLF0MHDmn6Oqt1OQA0aMbh1OzBlf1o4kzLjBUJikzJOiqslgZAu4otkizqkXVMcciQbXp2Anu+v/P6shoiJpeGH6Qrh0ANZYkUCtQDztkUzzQgy1oFmUWGy9xHY7wFkLKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1I2Caj6; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ef7c9e9592so44878987b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 25 Feb 2025 03:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740482847; x=1741087647; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=avvEE4O/GT37zS3KrjN1CF7hu6Jm8KN9KMeJJM+etas=;
        b=e1I2Caj6MUftCOOc3sHxcr6uZGSQMpjn5XsBqcNA6EHu3PablgXF/WVE8iLQYKdFn1
         u4XqFqLjTwkMDV/0SPIzKbLyo5FMuMcBXpNP0ZLKzLkzMqaIffY6agTvc4Cl70uqnIs8
         m1Fnwr02Q9uaJYQG4VcE9Td5kvCAIuX/UqisBqX24JKXtqAcxlXGVplAX5uCnQejm0DH
         P/97pzzYvizcXAbnE4Sa7MTmiE2+Am1VVjUjnTJPvnUTIFONXvj/ACW5qaKu1sjaMYoK
         rTar/usSXWzTkA18bDk0KF4jwAfm3GGoxE98IfhK5Si49+gGC8y63o2npzrjZD6DkRQA
         Dz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740482847; x=1741087647;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avvEE4O/GT37zS3KrjN1CF7hu6Jm8KN9KMeJJM+etas=;
        b=YUHebYz8l+rh+1uIyJdOAU6p10w4mMlWGET/KNwTiwx9N2iQVozj7+TJwzaB4G4OBZ
         7S+ovJrgHNkQpl7JIONXgPwDo8wxZh16HKjzFvNM7G9rdSXTE3BMitfZLvsMTPwn+QMh
         ccp3HVQM+QF7I6kVp+feCgoTK+M82XT8YTpUN7dT0POL2QQicpawlAjlvdeFZlipxVSW
         qbb340kcX5YEQSLU9Wzx0B3dME75o30BLxHuz4ATfeJyzon2RL8KRhgETW/kcz2Wl1v0
         Z0o1VudhjpkhLLTVO5UuM1MUNDC4B3qqpDz32KW2Lf70Ua/MsyF050CcBxIQ+662m9aH
         UYcg==
X-Gm-Message-State: AOJu0YyqGcK1AzaDe3mdeRlWWwt7gc+W6WLqtON3+tWHw19KktC4jZ6E
	BrVkjvPL/41bBk9OWq6LJh5c9On6DESJp9D6d1IZG/YOChCZ4TeHbaua5TFQYKlzBO8D+6wN6Pi
	2shQDq9HTKET8Yo+PJ0AENHT798vTTPHzRKRuJw==
X-Gm-Gg: ASbGnctdQsxNmeGYC8hxAsgJU3xNIDm7KlZ0LvBUia4SazgA/dJj9QE9tF5NT6akudQ
	42N2K2nEMIbBfz5D8RN8BGje5TGXeRnZc8d6giFtTrliVEYBW9F+FlGuQuN5wOFLodI0y0bG+ur
	j59dJfIQ==
X-Google-Smtp-Source: AGHT+IG6BpLP6IAN0Kt7r6mV3FmTAVUX7kkOlNewJjZnf6q6L/ukpdr9EBoimGD7nWuMwGGytazzdaD/ZyAXAEGZZo0=
X-Received: by 2002:a05:690c:4b12:b0:6ef:641a:2a73 with SMTP id
 00721157ae682-6fd109e692emr21250367b3.9.1740482847055; Tue, 25 Feb 2025
 03:27:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: RSINGH <rsingh.ind.1272@gmail.com>
Date: Tue, 25 Feb 2025 16:57:16 +0530
X-Gm-Features: AWEUYZkuin1xia4dFvOhc3-REmY6arbxjKVdMcxtlYLjfEvvWDNPMeluf1tnZyM
Message-ID: <CAD+278W-BG5tNPBJJ=gYwyygrotk+58-OCmv_LfsgHEwSAPEVw@mail.gmail.com>
Subject: Doubt about race condition between fallocate() and writeback path
To: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

I had the following doubt related to interaction between fallocate(),
write() and writeback path
Can someone please provide insights?

In ext4_punch_hole(), writeout of dirty pages is done before acquiring
inode lock as shown below:

==========================================
/*
* Write out all dirty pages to avoid race conditions
* Then release them.
*/
if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
ret = filemap_write_and_wait_range(mapping, offset,
  offset + length - 1);
if (ret)
return ret;
}

inode_lock(inode);
==========================================

Isn't there a chance that after writing dirty pages and before
acquiring inode lock, more pages can get dirtied while writeback path
is also processing the dirty pages?

Regards,
RS

