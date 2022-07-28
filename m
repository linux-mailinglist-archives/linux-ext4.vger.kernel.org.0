Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D105842DD
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jul 2022 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiG1PSc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Jul 2022 11:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiG1PSb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Jul 2022 11:18:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9364E872
        for <linux-ext4@vger.kernel.org>; Thu, 28 Jul 2022 08:18:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 460F320E32;
        Thu, 28 Jul 2022 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659021508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HYvChvCdcNcFONQF1jwR4x080OEBrjZ7b9xwSZWPRZA=;
        b=dhZrSbTvQYkikXol0B7vhV86JYB69ODj2vN0gVsf+flrzRnszDiL8Bw+iJfE0fkBKappRX
        eFNZ/V5xsEmkyCFDR0F0fC3/VvGj9Fg7INsJCDmMloOvygZNIrVH6L7KdqH8eVpJtM6qbI
        uIK6TjBpZiWYQ3RDbX8owQAnWyCRijk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659021508;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HYvChvCdcNcFONQF1jwR4x080OEBrjZ7b9xwSZWPRZA=;
        b=N7TKgtiK3ozZS/cHIkaAIDaFI7nILnmqmxqBJe48ehybh+5z3MiMaDbUEsSmVXq5lFCK1w
        EUa8MaWaqmdTZ+AA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 080292C141;
        Thu, 28 Jul 2022 15:18:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6CA4CA0668; Thu, 28 Jul 2022 17:18:27 +0200 (CEST)
Date:   Thu, 28 Jul 2022 17:18:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-ext4@vger.kernel.org
Cc:     Ted Tso <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: Ext4 mballoc behavior with mb_optimize_scan=1
Message-ID: <20220728151827.qxkm4rdb3mgc32up@quack3>
References: <20220727105123.ckwrhbilzrxqpt24@quack3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xlt464ngtv4j74tv"
Content-Disposition: inline
In-Reply-To: <20220727105123.ckwrhbilzrxqpt24@quack3>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--xlt464ngtv4j74tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

attached is the C program I use for reproducing the mballoc performance issue.
I run it as:

stress-unlink -s -c 100 -f 22528 16 0 /mnt

								Honza



On Wed 27-07-22 12:51:23, Jan Kara wrote:
> Hello,
> 
> before going on vacation I was tracking down why reaim benchmark regresses
> (10-20%) with larger number of processes with the new mb_optimize_scan
> strategy of mballoc. After a while I have reproduced the regression with a
> simple benchmark that just creates, fsyncs, and deletes lots of small files
> (22k) from 16 processes, each process has its own directory. The immediate
> reason for the slow down is that with mb_optimize_scan=1 the file blocks
> are spread among more block groups and thus we have more bitmaps to update
> in each transaction. 
> 
> So the question is why mballoc with mb_optimize_scan=1 spreads allocations
> more among block groups. The situation is somewhat obscured by group
> preallocation feature of mballoc where each *CPU* holds a preallocation and
> small (below 64k) allocations on that CPU are allocated from this
> preallocation. If I trace creating of these group preallocations I can see
> that the block groups they are taken from look like:
> 
> mb_optimize_scan=0:
> 49 81 113 97 17 33 113 49 81 33 97 113 81 1 17 33 33 81 1 113 97 17 113 113
> 33 33 97 81 49 81 17 49
> 
> mb_optimize_scan=1:
> 127 126 126 125 126 127 125 126 127 124 123 124 122 122 121 120 119 118 117
> 116 115 116 114 113 111 110 109 108 107 106 105 104 104
> 
> So we can see that while with mb_optimize_scan=0 the preallocation is
> always take from one of a few groups (among which we jump mostly randomly)
> which mb_optimize_scan=1 we consistently drift from higher block groups to
> lower block groups.
> 
> The mb_optimize_scan=0 behavior is given by the fact that search for free
> space always starts in the same block group where the inode is allocated
> and the inode is always allocated in the same block group as its parent
> directory. So the create-delete benchmark generally keeps all inodes for
> one process in the same block group and thus allocations are always
> starting in that block group. Because files are small, we always succeed in
> finding free space in the starting block group and thus allocations are
> generally restricted to the several block groups where parent directories
> were originally allocated.
> 
> With mb_optimize_scan=1 the block group to allocate from is selected by
> ext4_mb_choose_next_group_cr0() so in this mode we completely ignore the
> "pack inode with data in the same group" rule. The reason why we keep
> drifting among block groups is that whenever free space in a block group is
> updated (blocks allocated / freed) we recalculate largest free order (see
> mb_mark_used() and mb_free_blocks()) and as a side effect that removes
> group from the bb_largest_free_order_node list and reinserts the group at
> the tail.
> 
> I have two questions about the mb_optimize_scan=1 strategy:
> 
> 1) Shouldn't we respect the initial goal group and try to allocate from it
> in ext4_mb_regular_allocator() before calling ext4_mb_choose_next_group()?
> 
> 2) The rotation of groups in mb_set_largest_free_order() seems a bit
> undesirable to me. In particular it seems pointless if the largest free
> order does not change. Was there some rationale behind it?
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--xlt464ngtv4j74tv
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: attachment; filename="stress-unlink.c"

#define _GNU_SOURCE
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <getopt.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>

#define COUNT 5000
#define SIZE 16384
#define MAX_PROCS 1024

char shm_name[64];
char *wbuf;
int call_sync, use_falloc;
int count = COUNT;
int size = SIZE;

void prepare(char *base, int num)
{
	char dir[128];

	sprintf(dir, "%s/dir-%d", base, num);
	if (mkdir(dir, 0700) < 0 && errno != EEXIST) {
		perror("mkdir");
		exit(1);
	}
}

void teardown(char *base, int num)
{
	char dir[128];

	sprintf(dir, "%s/dir-%d", base, num);
	rmdir(dir);
}

void run_test(char *base, int num)
{
	char name[128];
	int shmfd;
	int i;
	int *shm;
	int fd;

	sprintf(name, "%s/dir-%d/file", base, num);
	shmfd = shm_open(shm_name, O_RDWR, 0);
	if (shmfd < 0) {
		perror("shm_open");
		exit(1);
	}
	shm = mmap(NULL, sizeof(int) * MAX_PROCS, PROT_READ | PROT_WRITE,
		   MAP_SHARED, shmfd, 0);
	if (shm == MAP_FAILED) {
		perror("mmap");
		exit(1);
	}
	shm[num + 1] = 1;
	while (shm[0] == 0)
		usleep(1);

	for (i = 0; i < count; i++) {
		fd = open(name, O_CREAT | O_WRONLY, 0644);
		if (fd < 0) {
			perror("open");
			exit(1);
		}
		if (use_falloc) {
			if (fallocate(fd, 0, 0, size) < 0) {
				perror("fallocate");
				exit(1);
			}
		} else {
			if (write(fd, wbuf, size) != size) {
				perror("write");
				exit(1);
			}
		}
		if (call_sync)
			fsync(fd);
		close(fd);
		unlink(name);
	}
}

pid_t start_flusher(char *base, int num)
{
	int fd;
	char name[128];
	pid_t pid;

	pid = fork();
	if (pid < 0) {
		perror("fork");
		return -1;
	}
	if (pid > 0)
		return pid;
	sprintf(name, "%s/sync-file-%d", base, num);
	fd = open(name, O_CREAT | O_TRUNC | O_WRONLY, 0644);
	if (fd < 0) {
		perror("open");
		exit(1);
	}
	while (1) {
		if (pwrite(fd, wbuf, size, 0) != size) {
			perror("pwrite");
			exit(1);
		}
		fsync(fd);
	}
}

int main(int argc, char **argv)
{
	int procs, sync_procs, i, j;
	pid_t pids[MAX_PROCS];
	pid_t sync_pids[MAX_PROCS];
	int shmfd;
	int *shm;
	struct timeval start, end;
	long long ms;
	int opt;
	char *path;

	while ((opt = getopt(argc, argv, "sc:f:a")) != -1) {
		switch (opt) {
		case 's':
			call_sync = 1;
			break;
		case 'a':
			use_falloc = 1;
			break;
		case 'c':
			count = atoi(optarg);
			break;
		case 'f':
			size = atoi(optarg);
			break;
		default:
usage:
			fprintf(stderr, "Usage: stress-unlink [-s] [-c <count>] [-f <filesize>] <processes> <flushers> <dir>\n");
			return 1;
		}
	}
	if (argc - optind != 3)
		goto usage;

	procs = strtol(argv[optind++], NULL, 10);
	if (procs > MAX_PROCS) {
		fprintf(stderr, "Too many processes!\n");
		return 1;
	}
	sync_procs = strtol(argv[optind++], NULL, 10);
	if (sync_procs > MAX_PROCS) {
		fprintf(stderr, "Too many flusher processes!\n");
		return 1;
	}
	path = argv[optind];

	wbuf = malloc(size);
	memset(wbuf, 0xcc, size);
	sprintf(shm_name, "/stress-unlink-%u", getpid());
	shmfd = shm_open(shm_name, O_CREAT | O_RDWR, 0600);
	if (shmfd < 0) {
		perror("shm_open");
		return 1;
	}
	if (ftruncate(shmfd, sizeof(int) * MAX_PROCS) < 0) {
		perror("ftruncate shm");
		return 1;
	}
	shm = mmap(NULL, sizeof(int) * MAX_PROCS, PROT_READ | PROT_WRITE,
		   MAP_SHARED, shmfd, 0);
	if (shm == MAP_FAILED) {
		perror("mmap");
		return 1;
	}
	
	shm[0] = 0;
	for (i = 0; i < procs; i++) {
		shm[i+1] = 0;
		prepare(path, i);
	}

	for (i = 0; i < procs; i++) {
		pids[i] = fork();
		if (pids[i] < 0) {
			perror("fork");
			for (j = 0; j < i; j++)
				kill(pids[j], SIGKILL);
			return 1;
		}
		if (pids[i] == 0) {
			run_test(path, i);
			exit(0);
		}
	}

	for (i = 0; i < sync_procs; i++) {
		sync_pids[i] = start_flusher(path, i);
		if (sync_pids[i] < 0) {
			for (j = 0; j < procs; j++)
				kill(pids[j], SIGKILL);
			for (j = 0; j < i; i++)
				kill(sync_pids[i], SIGKILL);
			exit(1);
		}
	}

	do {
		for (i = 0; i < procs && shm[i + 1]; i++);
	} while (i != procs);
	gettimeofday(&start, NULL);
	shm[0] = 1;
	fprintf(stderr, "Processes started.\n");

	for (i = 0; i < procs; i++)
		waitpid(pids[i], NULL, 0);
	gettimeofday(&end, NULL);
	for (i = 0; i < procs; i++)
		teardown(path, i);
	shm_unlink(shm_name);
	for (i = 0; i < sync_procs; i++)
		kill(sync_pids[i], SIGKILL);
	for (i = 0; i < sync_procs; i++)
		waitpid(sync_pids[i], NULL, 0);
	ms = (((long long)(end.tv_sec - start.tv_sec) * 1000000) +
		(end.tv_usec - start.tv_usec)) / 1000;
	printf("%lld.%03lld\n", ms/1000, ms%1000);
	
	return 0;
}

--xlt464ngtv4j74tv--
